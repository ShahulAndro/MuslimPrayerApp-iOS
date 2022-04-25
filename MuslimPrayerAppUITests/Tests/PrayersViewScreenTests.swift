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
//  PrayersViewScreenTests.swift
//  MuslimPrayerAppUITests
//
//  Created by Shahul Hamed Shaik (HLB) on 20/04/2022.
//

import XCTest

class PrayersViewScreenTests: BaseXCTestCase {

    func testPrayersView() {
        let prayersViewScreen = PrayersViewScreen(app: app)
        
        XCTAssertTrue(prayersViewScreen.verifyPageLoad())
    }

    func testPrayersHeaderView() {
        let prayersViewScreen = PrayersViewScreen(app: app)
        
        XCTAssertTrue(prayersViewScreen.verifyPageLoad())
        XCTAssertTrue(prayersViewScreen.verifyPrayerHeaderViewData())
    }
    

    func testPrayersTodayTableData() {
        let prayersViewScreen = PrayersViewScreen(app: app)
        
        XCTAssertTrue(prayersViewScreen.verifyPageLoad())
        XCTAssertTrue(prayersViewScreen.verifyPrayerHeaderViewData())
    }

    func testPrayersTableViewData() {
        let prayersViewScreen = PrayersViewScreen(app: app)
        
        XCTAssertTrue(prayersViewScreen.verifyPageLoad())
        XCTAssertTrue(prayersViewScreen.verifyPrayerTableViewData())
    }
    
    func testPreviousDatePrayers() {
        let prayersViewScreen = PrayersViewScreen(app: app)
        
        XCTAssertTrue(prayersViewScreen.verifyPageLoad())
        
        let date = prayersViewScreen.getIslamicDateFromNextPreviousSection()
        prayersViewScreen.tapOnPreviousButton().waitFor(seconds: 10)
        
        XCTAssertTrue(prayersViewScreen.verifyPrevious(date: date))
    }
    
    func testNextDatePrayers() {
        let prayersViewScreen = PrayersViewScreen(app: app)
        XCTAssertTrue(prayersViewScreen.verifyPageLoad())
        
        let date = prayersViewScreen.getIslamicDateFromNextPreviousSection()
        prayersViewScreen.tapOnNextButton().waitFor(seconds: 10)
        
        XCTAssertTrue(prayersViewScreen.verifyPrevious(date: date))
    }
    
    func testSelectZones() {
                let prayersViewScreen = PrayersViewScreen(app: app)
        XCTAssertTrue(prayersViewScreen.verifyPageLoad())
        
        prayersViewScreen.tapOnSelectZone().waitFor(seconds: 3)
        
        let zonesPopupList =  ZonesPopupListScreen(app: app)
        XCTAssertTrue(zonesPopupList.verifyZonesPopupListPageLoad())
    }
    
    func testSetttings() {
                let prayersViewScreen = PrayersViewScreen(app: app)
        XCTAssertTrue(prayersViewScreen.verifyPageLoad())
        
        prayersViewScreen.tapOnSettings().waitFor(seconds: 3)
        
        let settings =  SettingsScreen(app: app)
        XCTAssertTrue(settings.verifySettingsPageLoad())
    }

}
