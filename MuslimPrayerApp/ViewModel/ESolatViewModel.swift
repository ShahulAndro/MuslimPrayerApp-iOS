//
//  ESolatViewModel.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik (HLB) on 05/04/2022.
//

import Foundation
import RxSwift
import RxCocoa

class ESolatViewModel {
    
    public let takwimSolatData : PublishSubject<TakwimSolatData> = PublishSubject()
    public let showTomorrowPrayerTime : PublishSubject<(prayerType: String, prayerTime: String, dateString: String)> = PublishSubject()
    public let takwimSolatDataByPeriod : PublishSubject<TakwimSolatData> = PublishSubject()
    public let bgImagePrayerData: PublishSubject<BGImageByPrayerTimeData> = PublishSubject()
    public let bgImagePrayerImages: PublishSubject<[UIImage]> = PublishSubject()
    public let prayerTimes: PublishSubject<[(name: String, time: String)]> = PublishSubject()
    public let locationData : PublishSubject<[LocationData]> = PublishSubject()
    public let zoneTableDataPublish : PublishSubject<[ZoneSectionData]> = PublishSubject()
    
    var currentZone = "WLY01"
    var currentDisplayDate = ""
    var currentSelectePrayerTimeInTable = ""
    private var useRxToDownloadImage = false
    private var rxApiService: RXApiService?
    private var images: [UIImage] = []
    private let imageLoader = ImageLoader()
    private let disposeBag = DisposeBag()
    
    init(rxApiService: RXApiService = RXApiService()) {
        self.rxApiService = rxApiService
    }
    
}

extension ESolatViewModel {
    
    func fetchSirimTime() {
        let apiRequest = APIRequest(path: "SirimTime")
        
        rxApiService!.fetch(apiRequest: apiRequest).subscribe(
            onNext: { (serverTime: SirimTime) in
                print(serverTime.date ?? "")
                print(serverTime.serverTimestamp ?? "")
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
    
    func fetchTakwimSolat(period: String = "today", zone: String = "WLY01", date: String = "") {
        var queryParameterItems = [String: String]()
        
        queryParameterItems["period"] = period
        
        if currentZone.isEmpty {
            queryParameterItems["zone"] = zone
        } else {
            queryParameterItems["zone"] = currentZone
        }
        
        if !date.isEmpty {
            queryParameterItems["date"] = date
        }
        
        let apiRequest = APIRequest(path: "TakwimSolat", queryParameterItems: queryParameterItems)
        
        rxApiService!.fetch(apiRequest: apiRequest).subscribe(
            onNext: { (solatData: TakwimSolatData) in
                if solatData.prayerTime != nil && date.isEmpty {
                    self.takwimSolatData.onNext(solatData)
                } else {
                    if let prayerTime = solatData.prayerTime?.first {
                        let tomorrowData = (Utils.getNearestPrayerWith(prayerTime).prayerType, Utils.getNearestPrayerWith(prayerTime).prayerTime, date)
                        self.showTomorrowPrayerTime.onNext(tomorrowData)
                    }
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
        queryParameterItems["zone"] = currentZone
        
        var requestPayloadParameters = [String: String]()
        requestPayloadParameters["datestart"] = Utils.getDateFormatForApiFromddMMMyyyy(dateString: currentSelectePrayerTimeInTable, type: type)
        requestPayloadParameters["dateend"] = Utils.getDateFormatForApiFromddMMMyyyy(dateString: currentSelectePrayerTimeInTable, type: type)
        
        let apiRequest = APIRequest(method: RequestType.POST, path: "TakwimSolat", queryParameterItems: queryParameterItems, requestPayload: requestPayloadParameters)
        
        rxApiService!.fetch(apiRequest: apiRequest).subscribe(
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
    
    func fetchTarikhTakwim() {
        var queryParameterItems = [String: String]()
        queryParameterItems["period"] = "today"
        queryParameterItems["datetype"] = "miladi"
        let apiRequest = APIRequest(path: "tarikhtakwim", queryParameterItems: queryParameterItems)
        
        rxApiService!.fetch(apiRequest: apiRequest).subscribe(
            onNext: { (tarikhTakwim: TarikhTakwim) in
                if let takwim = tarikhTakwim.takwim {
                    print(takwim.keys)
                    print(takwim.values)
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
    
    func fetchTarikhTakwimHijri() {
        var queryParameterItems = [String: String]()
        queryParameterItems["period"] = "month"
        queryParameterItems["datetype"] = "hijri"
        queryParameterItems["hijri"] = "1443-09-01"
        let apiRequest = APIRequest(path: "tarikhtakwim", queryParameterItems: queryParameterItems)
        
        rxApiService!.fetch(apiRequest: apiRequest).subscribe(
            onNext: { (tarikhTakwim: TarikhTakwim) in
                if let takwim = tarikhTakwim.takwim {
                    print(takwim.keys)
                    print(takwim.values)
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
        let apiRequest = APIRequest(path: "BgImageByPrayertime", queryParameterItems: queryParameterItems)
        
        rxApiService!.fetch(apiRequest: apiRequest).subscribe(
            onNext: { (data: BGImageByPrayerTimeData) in
//                self.bgImagePrayerData.onNext(data)
                
                if self.useRxToDownloadImage {
                    self.downloadImagesWithRx(data: data)
                } else {
//                    self.loadAllImages(data: data)
                    self.combineAllImagesRequestWithRxZip(data: data)
                }
                
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
        let apiRequest = APIRequest(path: "nearestMosque", queryParameterItems: queryParameterItems)
        
        rxApiService!.fetch(apiRequest: apiRequest).subscribe(
            onNext: { (mosqueLocations: MosqueLocations) in
                if let locationData = mosqueLocations.locationData {
                    self.locationData.onNext(locationData.sorted(by: { $0.distance  < $1.distance }))
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
    
    func fetchZoneTableData() {
        let sequences = Observable.just(ZonesTableData.zoneSections())
        sequences.subscribe(onNext: { [weak self] (data) in
            self?.zoneTableDataPublish.onNext(data)
        }).disposed(by: disposeBag)
    }
}

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
    
    func loadAllImages(data: BGImageByPrayerTimeData) {
        
        let dispatchQueue = DispatchQueue.global(qos: .utility)
        let dispathGroup = DispatchGroup()
        
        dispathGroup.enter()
        dispatchQueue.async(group: dispathGroup) {
            if let bg_imagePath = data.data?.bg_images1 {
                self.imageLoader.loadImageWithURLSession(from: bg_imagePath, completionHandler: { (image) in
                    defer { dispathGroup.leave() }
                    if let image = image {
                        self.images.append(image)
                    }
                })
            }
        }
        
        dispathGroup.enter()
        dispatchQueue.async(group: dispathGroup) {
            if let bg_imagePath = data.data?.bg_images2 {
                self.imageLoader.loadImageWithURLSession(from: bg_imagePath, completionHandler: { (image) in
                    
                    defer { dispathGroup.leave() }
                    
                    if let image = image {
                        self.images.append(image)
                    }
                })
            }
        }
        
        dispathGroup.enter()
        dispatchQueue.async(group: dispathGroup) {
            if let bg_imagePath = data.data?.bg_images3 {
                self.imageLoader.loadImageWithURLSession(from: bg_imagePath, completionHandler: { (image) in
                    defer { dispathGroup.leave() }
                    
                    if let image = image {
                        self.images.append(image)
                    }
                })
            }
        }
        
        dispathGroup.enter()
        dispatchQueue.async(group: dispathGroup) {
            if let bg_imagePath = data.data?.bg_images4 {
                self.imageLoader.loadImageWithURLSession(from: bg_imagePath, completionHandler: { (image) in
                    defer { dispathGroup.leave() }
                    if let image = image {
                        self.images.append(image)
                    }
                })
            }
        }
        
        dispathGroup.enter()
        dispatchQueue.async(group: dispathGroup) {
            if let bg_imagePath = data.data?.bg_images5 {
                self.imageLoader.loadImageWithURLSession(from: bg_imagePath, completionHandler: { (image) in
                    defer { dispathGroup.leave() }
                    if let image = image {
                        self.images.append(image)
                    }
                })
            }
        }
        
        dispathGroup.notify(queue: DispatchQueue.global()) {
            self.bgImagePrayerImages.onNext(self.images)
        }
    }
    
    func downloadImagesWithRx(data: BGImageByPrayerTimeData) {
        if let bg_images1 = data.data?.bg_images1, let url = URL(string: "\(String(describing: Utils.baseUrl))\(bg_images1)") {
            self.imageLoader.loadImageWithRX(from: url)
        }
        
        if let bg_images2 = data.data?.bg_images2, let url = URL(string: "\(String(describing: Utils.baseUrl))\(bg_images2)") {
            self.imageLoader.loadImageWithRX(from: url)
        }
        
        if let bg_images3 = data.data?.bg_images3, let url = URL(string: "\(String(describing: Utils.baseUrl))\(bg_images3)") {
            self.imageLoader.loadImageWithRX(from: url)
        }
        
        if let bg_images4 = data.data?.bg_images4, let url = URL(string: "\(String(describing: Utils.baseUrl))\(bg_images4)") {
            self.imageLoader.loadImageWithRX(from: url)
        }
        
        if let bg_images5 = data.data?.bg_images5, let url = URL(string: "\(String(describing: Utils.baseUrl))\(bg_images5)") {
            self.imageLoader.loadImageWithRX(from: url)
        }
    }
    
    func combineAllImagesRequestWithRxZip(data: BGImageByPrayerTimeData) {
        let imageRequestObservables = requestURLs(data: data)
        
        Observable
            .zip(imageRequestObservables)
            .observe(on:MainScheduler.instance)
            .subscribe(onNext: { (responseArray) in
                var images = [UIImage]()
                for response in responseArray {
                    if let image = UIImage(data: response.data) {
                        images.append(image)
                    }
                }
                
                if !images.isEmpty {
                    self.bgImagePrayerImages.onNext(images)
                }
            })
            .disposed(by: disposeBag)
        
        
    }
    
    func requestURLs(data: BGImageByPrayerTimeData)-> [Observable<(response: HTTPURLResponse, data: Data)>] {
        var imageRequestObservables = [Observable<(response: HTTPURLResponse, data: Data)>]()
        
        if let bgImage1 =  data.data?.bg_images1?.escapedStringForURL, !bgImage1.isEmpty, let url = URL(string: "\(String(describing: Utils.baseUrl))\(bgImage1)") {
            imageRequestObservables.append(URLSession.shared.rx.response(request: URLRequest(url: url)))
        }
        
        if let bgImage2 =  data.data?.bg_images2?.escapedStringForURL, !bgImage2.isEmpty, let url = URL(string: "\(String(describing: Utils.baseUrl))\(bgImage2)") {
            imageRequestObservables.append(URLSession.shared.rx.response(request: URLRequest(url: url)))
        }
        
        if let bgImage3 =  data.data?.bg_images3?.escapedStringForURL, !bgImage3.isEmpty, let url = URL(string: "\(String(describing: Utils.baseUrl))\(bgImage3)") {
            imageRequestObservables.append(URLSession.shared.rx.response(request: URLRequest(url: url)))
        }
        
        if let bgImage4 =  data.data?.bg_images4?.escapedStringForURL, !bgImage4.isEmpty, let url = URL(string: "\(String(describing: Utils.baseUrl))\(bgImage4)") {
            imageRequestObservables.append(URLSession.shared.rx.response(request: URLRequest(url: url)))
        }
        
        if let bgImage5 =  data.data?.bg_images5?.escapedStringForURL, !bgImage5.isEmpty, let url = URL(string: "\(String(describing: Utils.baseUrl))\(bgImage5)") {
            imageRequestObservables.append(URLSession.shared.rx.response(request: URLRequest(url: url)))
        }
        
        return imageRequestObservables
    }
    
}
