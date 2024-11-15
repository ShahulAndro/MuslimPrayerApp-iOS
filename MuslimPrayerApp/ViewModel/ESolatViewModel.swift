/*
 * Copyright 2022 Shahul Hameed Shaik
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//
//  ESolatViewModel.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik on 05/04/2022.
//
//  Copyright 2022 Shahul Hameed Shaik
//

import Foundation
import RxSwift
import RxCocoa

class ESolatViewModel {
    
    public let takwimSolatData : PublishSubject<TakwimSolatData> = PublishSubject()
    public let scheduleNotificationsWithSolatData : PublishSubject<TakwimSolat> = PublishSubject()
    public let showTomorrowPrayerTime : PublishSubject<(prayerType: String, prayerTime: String, dateString: String)> = PublishSubject()
    public let takwimSolatDataByPeriod : PublishSubject<TakwimSolatData> = PublishSubject()
    public let bgImagePrayerImages: PublishSubject<[UIImage]> = PublishSubject()
    public let locationData : PublishSubject<[LocationData]> = PublishSubject()
    public let prayerTimes: PublishSubject<[(name: String, time: String)]> = PublishSubject()
    public let zoneTableDataPublish : PublishSubject<[ZoneSectionData]> = PublishSubject()
    public let loadingIndicatorPublish = PublishSubject<Void>()
    
    private var rxApiService: APIServiceProtocol?
    private let disposeBag = DisposeBag()
    
    var currentSelectePrayerTimeInTable = ""
    var currentPrayer: (name: String, time: String)?
    
    init(rxApiService: APIServiceProtocol = RXApiService()) {
        self.rxApiService = rxApiService
    }
    
}

//MARK: - API calls

extension ESolatViewModel {
    
    func fetchTakwimSolat(period: String = "today", date: String = "") {
        var queryParameterItems = [String: String]()
        
        queryParameterItems["period"] = period
        
        queryParameterItems["zone"] = UserDefaultHelper.selectedZone() ?? "WLY01"
        
        if !date.isEmpty {
            queryParameterItems["date"] = date
        }
        
        let apiRequest = APIRequest(path: APIRequest.pathTakwimSolat, queryParameterItems: queryParameterItems)
        
        rxApiService!.performRequest(apiRequest: apiRequest).subscribe(
            onNext: { (solatData: TakwimSolatData) in
                if solatData.prayerTime != nil && date.isEmpty {
                    self.takwimSolatData.onNext(solatData)
                } else {
                    if let prayerTime = solatData.prayerTime?.first {
                        let tomorrowData = (Utils.getNearestPrayerWith(prayerTime).prayerType, Utils.getNearestPrayerWith(prayerTime).prayerTime, date)
                        self.showTomorrowPrayerTime.onNext(tomorrowData)
                    }
                }
                
                if let solatInfo = solatData.prayerTime?.first {
                    self.scheduleNotificationsWithSolatData.onNext(solatInfo)
                }
            }, onError: { error in
                print(error)
            },
            onCompleted: {
                print("onCompleted")
            },
            onDisposed: {
                print("onDisposed")
            }).disposed(by: rxApiService!.disposeBag)
    }
    
    
    func fetchTakwimSolatByPeriod(period: String = "duration", type: PrayerTimeType) {
        var queryParameterItems = [String: String]()
        queryParameterItems["period"] = period
        queryParameterItems["zone"] = UserDefaultHelper.selectedZone() ?? "WLY01"
        
        var requestPayloadParameters = [String: String]()
        requestPayloadParameters["datestart"] = Utils.getDateFormatForApiFromddMMMyyyy(dateString: currentSelectePrayerTimeInTable, type: type)
        requestPayloadParameters["dateend"] = Utils.getDateFormatForApiFromddMMMyyyy(dateString: currentSelectePrayerTimeInTable, type: type)
        
        let apiRequest = APIRequest(method: RequestType.POST, path: APIRequest.pathTakwimSolat, queryParameterItems: queryParameterItems, requestPayload: requestPayloadParameters)
        
        rxApiService!.performRequest(apiRequest: apiRequest).subscribe(
            onNext: { (solatData: TakwimSolatData) in
                if solatData.prayerTime != nil {
                    self.takwimSolatDataByPeriod.onNext(solatData)
                }
            }, onError: { error in
                print(error)
            },
            onCompleted: {
                print("onCompleted")
            },
            onDisposed: {
                print("onDisposed")
            }).disposed(by: rxApiService!.disposeBag)
    }
    
    func fetchBGImageByPrayerTime(prayterType: String = "Zohor") {
        var queryParameterItems = [String: String]()
        queryParameterItems["praytime"] = prayterType
        let apiRequest = APIRequest(path: APIRequest.pathBgImageByPrayertime, queryParameterItems: queryParameterItems)
        
        rxApiService!.performRequest(apiRequest: apiRequest).subscribe(
            onNext: { (data: BGImageByPrayerTimeData) in
               self.combineAllImagesRequestWithRxZip(data: data)
            }, onError: { error in
                print(error)
            })
            .disposed(by: rxApiService!.disposeBag)
    }
    
    func fetchNearestMosques(lat: String, long: String, dist: String = "7") {
        var queryParameterItems = [String: String]()
        queryParameterItems["lat"] = lat
        queryParameterItems["long"] = long
        queryParameterItems["dist"] = dist
        let apiRequest = APIRequest(path: APIRequest.pathNearestMosque, queryParameterItems: queryParameterItems)
        
        rxApiService!.performRequest(apiRequest: apiRequest).subscribe(
            onNext: { (mosqueLocations: MosqueLocations) in
                if let locationData = mosqueLocations.locationData {
                    self.locationData.onNext(locationData.sorted(by: { $0.distance ?? "0"  < $1.distance ?? "0" }))
                    self.loadingIndicatorPublish.onNext(())
                }
            }, onError: { error in
                print(error)
            },
            onCompleted: {
                print("onCompleted")
            },
            onDisposed: {
                print("onDisposed")
            }).disposed(by: rxApiService!.disposeBag)
    }
    
    func combineAllImagesRequestWithRxZip(data: BGImageByPrayerTimeData) {
        let images = getBGPrayerImagesFromImageCache(data: data)
        if images.count > 0 {
            self.bgImagePrayerImages.onNext(images)
            return
        }
        
        let imageRequestObservables = requestURLs(data: data)
        Observable
            .zip(imageRequestObservables)
            .observe(on:MainScheduler.instance)
            .subscribe(onNext: { (responseArray) in
                let imageCache = ImageCache()
                var images = [UIImage]()
                for response in responseArray {
                    if let image = UIImage(data: response.data) {
                        images.append(image)
                        if let url = response.response.url, imageCache.image(for: url) == nil {
//                            imageCache.insertImage(image, for: url) //TODO: Check already available image
                        }
                        
                    }
                }
                
                if !images.isEmpty {
                    self.bgImagePrayerImages.onNext(images)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func fetchZoneTableData() {
        let sequences = Observable.just(ZonesTableData.zoneSections())
        sequences.subscribe(onNext: { [weak self] (data) in
            self?.zoneTableDataPublish.onNext(data)
        }).disposed(by: disposeBag)
    }
}


//MARK: - without API calls

extension ESolatViewModel {
    
    func getPrayerTimeList(_ prayerTime: TakwimSolat)->  [(name: String, time: String)] {
        var prayerList = [(name: String, time: String)]()
        prayerList.append((PrayerType.Imsak.rawValue, prayerTime.imsak ?? ""))
        prayerList.append((PrayerType.Fajr.rawValue, prayerTime.fajr ?? ""))
        prayerList.append((PrayerType.Syuruk.rawValue, prayerTime.syuruk ?? ""))
        prayerList.append((PrayerType.Dhuhr.rawValue, prayerTime.dhuhr ?? ""))
        prayerList.append((PrayerType.Asar.rawValue, prayerTime.asr ?? ""))
        prayerList.append((PrayerType.Maghrib.rawValue, prayerTime.maghrib ?? ""))
        prayerList.append((PrayerType.Isha.rawValue, prayerTime.isha ?? ""))
        
        return prayerList
    }
    
    func requestURLs(data: BGImageByPrayerTimeData)-> [Observable<(response: HTTPURLResponse, data: Data)>] {
        var imageRequestObservables = [Observable<(response: HTTPURLResponse, data: Data)>]()
        
        if let bgImage1 =  data.data?.bg_images1?.escapedStringForURL, !bgImage1.isEmpty, let url = URL(string: "\(String(describing: APIRequest.baseUrl))\(bgImage1)") {
            imageRequestObservables.append(URLSession.shared.rx.response(request: URLRequest(url: url)))
        }
        
        if let bgImage2 =  data.data?.bg_images2?.escapedStringForURL, !bgImage2.isEmpty, let url = URL(string: "\(String(describing: APIRequest.baseUrl))\(bgImage2)") {
            imageRequestObservables.append(URLSession.shared.rx.response(request: URLRequest(url: url)))
        }
        
        if let bgImage3 =  data.data?.bg_images3?.escapedStringForURL, !bgImage3.isEmpty, let url = URL(string: "\(String(describing: APIRequest.baseUrl))\(bgImage3)") {
            imageRequestObservables.append(URLSession.shared.rx.response(request: URLRequest(url: url)))
        }
        
        if let bgImage4 =  data.data?.bg_images4?.escapedStringForURL, !bgImage4.isEmpty, let url = URL(string: "\(String(describing: APIRequest.baseUrl))\(bgImage4)") {
            imageRequestObservables.append(URLSession.shared.rx.response(request: URLRequest(url: url)))
        }
        
        if let bgImage5 =  data.data?.bg_images5?.escapedStringForURL, !bgImage5.isEmpty, let url = URL(string: "\(String(describing: APIRequest.baseUrl))\(bgImage5)") {
            imageRequestObservables.append(URLSession.shared.rx.response(request: URLRequest(url: url)))
        }
        
        return imageRequestObservables
    }
    
    private func getBGPrayerImagesFromImageCache(data: BGImageByPrayerTimeData)-> [UIImage] {
        let imageCache = ImageCache()
        var images = [UIImage]()
        if let bgImage1 =  data.data?.bg_images1?.escapedStringForURL, !bgImage1.isEmpty, let url = URL(string: "\(String(describing: APIRequest.baseUrl))\(bgImage1)") {
            if let image = imageCache[url] {
                images.append(image)
            }
        }
        
        if let bgImage2 =  data.data?.bg_images2?.escapedStringForURL, !bgImage2.isEmpty, let url = URL(string: "\(String(describing: APIRequest.baseUrl))\(bgImage2)") {
            if let image = imageCache[url] {
                images.append(image)
            }
        }
        
        if let bgImage3 =  data.data?.bg_images3?.escapedStringForURL, !bgImage3.isEmpty, let url = URL(string: "\(String(describing: APIRequest.baseUrl))\(bgImage3)") {
            if let image = imageCache[url] {
                images.append(image)
            }
        }
        
        if let bgImage4 =  data.data?.bg_images4?.escapedStringForURL, !bgImage4.isEmpty, let url = URL(string: "\(String(describing: APIRequest.baseUrl))\(bgImage4)") {
            if let image = imageCache[url] {
                images.append(image)
            }
        }
        
        if let bgImage5 =  data.data?.bg_images5?.escapedStringForURL, !bgImage5.isEmpty, let url = URL(string: "\(String(describing: APIRequest.baseUrl))\(bgImage5)") {
            if let image = imageCache[url] {
                images.append(image)
            }
        }
        
        return images
    }
    
}
