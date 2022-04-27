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
//  MainTabBarViewScreen.swift
//  MuslimPrayerAppUITests
//
//  Created by Shahul Hamed Shaik on 21/04/2022.
//

import Foundation
import XCTest


class MainTabBarViewScreen {
    
    let app: XCUIApplication
    let prayerTabItem: XCUIElement
    let findMosquesTabItem: XCUIElement
    
    init(app: XCUIApplication) {
        self.app = app
        let tabBar = app.tabBars["Tab Bar"]
        prayerTabItem = tabBar.buttons["Prayers"]
        findMosquesTabItem = tabBar.buttons["Find Mosques"]
    }
    
    func waitFor(seconds: Int) {
        _ = app.waitForExistence(timeout: TimeInterval(seconds))
    }
    
    func tapPrayerTabItem()-> Self {
        prayerTabItem.tap()
        return self
    }
    
    func tapFindMosquesTabItem()-> Self {
        findMosquesTabItem.tap()
        return self
    }
    
    func verifyPageLoad()-> Bool {
        return prayerTabItem.waitForExistence(timeout: 10)
        && prayerTabItem.exists
        && findMosquesTabItem.exists
    }
    
}
