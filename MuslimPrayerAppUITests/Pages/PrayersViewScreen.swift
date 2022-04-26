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
//  PrayersViewScreen.swift
//  MuslimPrayerAppUITests
//
//  Created by Shahul Hamed Shaik on 20/04/2022.
//

import Foundation
import XCTest

class PrayersViewScreen {
    
    let app: XCUIApplication
    let rootContentView: XCUIElement
    let headerView: XCUIElement
    let prayerBGImageView: XCUIElement
    let settingsImageView: XCUIElement
    let headerStackView: XCUIElement
    let eDateLabel: XCUIElement
    let iDateLabel: XCUIElement
    let nextPrayerTimeLabel: XCUIElement
    let prayerTypeLabel: XCUIElement
    let prayerTimeLabel: XCUIElement
    let selectZoneButton: XCUIElement
    let timeRemainingForPrayerView: XCUIElement
    let hoursLabel: XCUIElement
    let minsLabel: XCUIElement
    let secLabel: XCUIElement
    let zoneLabel: XCUIElement
    let prayerDateSelectionView: XCUIElement
    let previousButton: XCUIElement
    let islamicDateLabel: XCUIElement
    let nextButton: XCUIElement
    let prayerView: XCUIElement
    let prayerTableView: XCUIElement
    let loadingIndicator: XCUIElement
    
    init(app: XCUIApplication) {
        self.app = app
        self.rootContentView = app.otherElements["rootContentView"]
        self.headerView = app.otherElements["headerView"]
        self.prayerBGImageView = app.images["prayerBGImageView"]
        self.settingsImageView = app.images["settingsImageView"]
        self.headerStackView = app.otherElements["headerStackView"]
        self.eDateLabel = app.staticTexts["eDateLabel"]
        self.iDateLabel = app.staticTexts["iDateLabel"]
        self.nextPrayerTimeLabel = app.staticTexts["nextPrayerTimeLabel"]
        self.prayerTypeLabel = app.staticTexts["prayerTypeLabel"]
        self.prayerTimeLabel = app.staticTexts["prayerTimeLabel"]
        self.selectZoneButton = app.buttons["selectZoneButton"]
        self.timeRemainingForPrayerView = app.otherElements["timeRemainingForPrayerView"]
        self.hoursLabel = app.staticTexts["hoursLabel"]
        self.minsLabel = app.staticTexts["minsLabel"]
        self.secLabel = app.staticTexts["secLabel"]
        self.zoneLabel = app.staticTexts["zoneLabel"]
        self.prayerDateSelectionView = app.otherElements["prayerDateSelectionView"]
        self.previousButton = app.buttons["previousButton"]
        self.islamicDateLabel = app.staticTexts["islamicDateLabel"]
        self.nextButton = app.buttons["nextButton"]
        self.prayerView = app.otherElements["prayerView"]
        self.prayerTableView = app.tables["prayerTableView"]
        self.loadingIndicator = app.otherElements["loadingIndicator"]
    }
    
    
    func tapOnSettings()-> Self {
        settingsImageView.tap()
        return self
    }
    
    func tapOnSelectZone()-> Self {
        selectZoneButton.tap()
        return self
    }
    
    func tapOnPreviousButton()-> Self {
        previousButton.tap()
        return self
    }
    
    func waitFor(seconds: Int) {
        _ = app.waitForExistence(timeout: TimeInterval(seconds))
    }
    
    func tapOnNextButton()-> Self {
        nextButton.tap()
        return self
    }
    
    func getIslamicDateFromNextPreviousSection()-> String {
        return islamicDateLabel.label
    }
    
    func verifyNext(date: String)-> Bool {
        return islamicDateLabel.label != date
    }
    
    func verifyPrevious(date: String)-> Bool {
        return islamicDateLabel.label != date
    }
    
    func verifyPrayerTableData()-> Bool {
        
        return prayerTableView.exists
    }
    
    func verifyPrayerTableViewData()-> Bool {
        
        if prayerTableView.exists && prayerTableView.cells.allElementsBoundByIndex.count == 7 {
            return true
        }
        
        return false
    }
    
    func verifyPrayerHeaderViewData()-> Bool {
        
        return prayerBGImageView.isEnabled
        && settingsImageView.isEnabled && settingsImageView.isHittable
        && !eDateLabel.label.isEmpty
        && !iDateLabel.label.isEmpty
        && !nextPrayerTimeLabel.label.isEmpty
        && !prayerTypeLabel.label.isEmpty
        && !prayerTimeLabel.label.isEmpty
        && !hoursLabel.label.isEmpty
        && !minsLabel.label.isEmpty
        && !secLabel.label.isEmpty
        && zoneLabel.isEnabled && zoneLabel.isHittable
    }
    
    
    func verifyPageLoad()->  Bool {
        return rootContentView.waitForExistence(timeout: 10)
        && headerView.exists
        && prayerBGImageView.exists
        && settingsImageView.exists
        && headerStackView.exists
        && eDateLabel.exists
        && iDateLabel.exists
        && nextPrayerTimeLabel.exists
        && prayerTypeLabel.exists
        && prayerTimeLabel.exists
        && timeRemainingForPrayerView.exists
        && hoursLabel.exists
        && minsLabel.exists
        && secLabel.exists
        && zoneLabel.exists
        && prayerDateSelectionView.exists
        && previousButton.exists
        && islamicDateLabel.exists
        && nextButton.exists
        && prayerView.exists
        && prayerTableView.exists
    }
    
    
}
