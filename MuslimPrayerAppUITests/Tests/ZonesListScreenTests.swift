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
//  ZonesListScreenTests.swift
//  MuslimPrayerAppUITests
//
//  Created by Shahul Hamed Shaik (HLB) on 20/04/2022.
//

import XCTest

class ZonesListScreenTests: BaseXCTestCase {
    
    func testVerifyZonesListPageLoad() {
        let prayersViewScreen = PrayersViewScreen(app: app)
        XCTAssertTrue(prayersViewScreen.verifyPageLoad())
        
        prayersViewScreen.tapOnSelectZone().waitFor(seconds: 3)
        
        let zonesPopupList =  ZonesPopupListScreen(app: app)
        XCTAssertTrue(zonesPopupList.verifyZonesPopupListPageLoad())
        XCTAssertTrue(zonesPopupList.verifyZonesTableViewData())
    }
    
    func testZonesListScroll() {
        let prayersViewScreen = PrayersViewScreen(app: app)
        XCTAssertTrue(prayersViewScreen.verifyPageLoad())
        
        prayersViewScreen.tapOnSelectZone().waitFor(seconds: 3)
        
        let zonesPopupList =  ZonesPopupListScreen(app: app)
        XCTAssertTrue(zonesPopupList.verifyZonesPopupListPageLoad())
        XCTAssertTrue(zonesPopupList.verifyZonesTableViewData())
        
        zonesPopupList.scrollTableView(maxScrolls: 10)
        let lastCellText = zonesPopupList.getLastCellText()
        XCTAssertTrue(!lastCellText.isEmpty)
        
        XCTAssertTrue(zonesPopupList.verifyLastCellText(text: lastCellText))
    }
    
    func testCancelNavigation() {
        let prayersViewScreen = PrayersViewScreen(app: app)
        XCTAssertTrue(prayersViewScreen.verifyPageLoad())
        
        prayersViewScreen.tapOnSelectZone().waitFor(seconds: 3)
        
        let zonesPopupList =  ZonesPopupListScreen(app: app)
        XCTAssertTrue(zonesPopupList.verifyZonesPopupListPageLoad())
        
        zonesPopupList.tapOnCancel()
        
        XCTAssertTrue(prayersViewScreen.verifyPageLoad())
    }
}
