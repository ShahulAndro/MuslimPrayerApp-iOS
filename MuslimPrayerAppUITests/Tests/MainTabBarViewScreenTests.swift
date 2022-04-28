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
//  MainTabBarViewScreenTests.swift
//  MuslimPrayerAppUITests
//
//  Created by Shahul Hamed Shaik on 23/04/2022.
//
//  Copyright 2022 Shahul Hameed Shaik
//

import XCTest

class MainTabBarViewScreenTests: BaseXCTestCase {
    
    func testMainTabBarViewScreen() {
        let tabBarScreen = MainTabBarViewScreen(app: app)
        XCTAssertTrue(tabBarScreen.verifyPageLoad())
    }
    
    func testMainTabBarItemsPages() {
        let tabBarScreen = MainTabBarViewScreen(app: app)
        XCTAssertTrue(tabBarScreen.verifyPageLoad())
        
        let prayersViewScreen = PrayersViewScreen(app: app)
        XCTAssertTrue(prayersViewScreen.verifyPageLoad())
        
        tabBarScreen.tapFindMosquesTabItem().waitFor(seconds: 10)
        let nearMosquesScreen = NearMosquesScreen(app: app)
        XCTAssertTrue(nearMosquesScreen.verifyPageLoad())
        
        tabBarScreen.tapPrayerTabItem().waitFor(seconds: 5)
        XCTAssertTrue(prayersViewScreen.verifyPageLoad())
    }
    
}
