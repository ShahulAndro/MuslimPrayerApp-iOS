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
//  ESolatViewModelTests.swift
//  MuslimPrayerAppTests
//
//  Created by Shahul Hamed Shaik (HLB) on 16/04/2022.
//

import XCTest
import RxSwift
import RxTest

class ESolatViewModelTests: XCTestCase {

    var disposeBag: DisposeBag?
    var viewModel: ESolatViewModel?
    var testScheduler: TestScheduler?
    var rxApiService: MockRXApiService?
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        rxApiService = MockRXApiService()
        viewModel = ESolatViewModel(rxApiService: rxApiService!)
        testScheduler = TestScheduler(initialClock: 0)
    }

    override func tearDown() {
        disposeBag = nil
        rxApiService = nil
        viewModel = nil
        testScheduler = nil
        super.tearDown()
        
    }
    
    func testFetchTakwimSolat() {
        rxApiService?.output = DataManager.getTakwimSolatData()
        viewModel?
            .takwimSolatData
            .bind(onNext: { (data) in
                XCTAssertNotNil(data)
                XCTAssertNotNil(data as TakwimSolatData)
            })
            .disposed(by: disposeBag!)
        
        viewModel?
            .fetchTakwimSolat()
        
    }
    
    func testFetchNearestMosques() {
        rxApiService?.output = DataManager.getNearestMosquesData()
        viewModel?
            .locationData
            .bind(onNext: { (data) in
                XCTAssertNotNil(data)
                XCTAssertNotNil(data as [LocationData])
            })
            .disposed(by: disposeBag!)
        
        viewModel?
            .fetchNearestMosques(lat: "3.141812", long: "101.691695", dist: "7")
    }
    
    func testFetchBGImageByPrayerTime() {
        rxApiService?.output = DataManager.getBgImageByPrayertimeData()
        viewModel?
            .bgImagePrayerImages
            .bind(onNext: { (data) in
                XCTAssertNotNil(data)
                XCTAssertNotNil(data as [UIImage])
            })
            .disposed(by: disposeBag!)
        
        viewModel?
            .fetchBGImageByPrayerTime()
    }
    
    func testGetPrayerTimeList() {
        let takwimSolat = DataManager.getTakwimSolatData()
        let prayerTime = takwimSolat.prayerTime?.first
        
        var expected = [(name: String, time: String)]()
        expected.append((PrayerType.Imsak.rawValue, prayerTime?.imsak ?? ""))
        expected.append((PrayerType.Fajr.rawValue, prayerTime?.fajr ?? ""))
        expected.append((PrayerType.Syuruk.rawValue, prayerTime?.syuruk ?? ""))
        expected.append((PrayerType.Dhuhr.rawValue, prayerTime?.dhuhr ?? ""))
        expected.append((PrayerType.Asar.rawValue, prayerTime?.asr ?? ""))
        expected.append((PrayerType.Maghrib.rawValue, prayerTime?.maghrib ?? ""))
        expected.append((PrayerType.Isha.rawValue, prayerTime?.isha ?? ""))
        
        let actual = viewModel?.getPrayerTimeList(prayerTime!)
        
        XCTAssertNotNil(actual)
        XCTAssertEqual(expected.count, actual?.count)
        for prayer in actual! {
            XCTAssertTrue(!(prayer.name.isEmpty && prayer.time.isEmpty))
        }
    }
    
    func testRequestURLs() {
        let prayerImageData = DataManager.getBgImageByPrayertimeData()
        
        let actualData = viewModel?.requestURLs(data: prayerImageData)
        
        XCTAssertNotNil(actualData)
        XCTAssertTrue(actualData?.count == 5)
    }
    
    func testFetchZoneTableData() {
        viewModel?
            .zoneTableDataPublish
            .bind(onNext: { (data) in
                XCTAssertNotNil(data)
                let zonesData = data as [ZoneSectionData]
                XCTAssertNotNil(zonesData)
                XCTAssertTrue(zonesData.count == 16)
                for zones in zonesData {
                    XCTAssertNotNil(zones.items)
                    XCTAssertTrue(zones.items.count > 0)
                }
            })
            .disposed(by: disposeBag!)
        
        viewModel?
            .fetchZoneTableData()
    }

}
