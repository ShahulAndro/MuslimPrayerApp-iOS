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
//  ZonesPopupListScreen.swift
//  MuslimPrayerAppUITests
//
//  Created by Shahul Hamed Shaik on 20/04/2022.
//
//  Copyright 2022 Shahul Hameed Shaik
//

import Foundation
import XCTest

class ZonesPopupListScreen {
    
    let app: XCUIApplication
    let chooseZonePlaceHolderLabel: XCUIElement
    let zoneTableView: XCUIElement
    let cancelButton: XCUIElement
    
    init(app: XCUIApplication) {
        self.app = app
        self.chooseZonePlaceHolderLabel = app.staticTexts["chooseZonePlaceHolderLabel"]
        self.zoneTableView = app.tables["zoneTableView"]
        self.cancelButton = app.buttons["cancelButton"]
    }
    
    
    func tapOnCancel() {
        cancelButton.tap()
    }
    
    func scrollTableView(maxScrolls: Int) {
        guard let lastCell = zoneTableView.cells.allElementsBoundByIndex.last else { return }
        
        var count = 0
        while lastCell.isHittable == false && count < maxScrolls {
            app.swipeUp()
            count += 1
        }
    }
    
    func getLastCellText()-> String {
        let textInLastCell = zoneTableView.cells.allElementsBoundByIndex.last?.descendants(matching: .staticText).firstMatch
        return textInLastCell?.label ?? ""
    }
    
    func verifyLastCellText(text: String)-> Bool {
        return text.contains("TRG04")
    }
    
    func verifyZonesTableViewData()-> Bool {
        return zoneTableView.cells.allElementsBoundByIndex.count > 0
    }
    
    func verifyZonesPopupListPageLoad()-> Bool {
        
        return chooseZonePlaceHolderLabel.exists
        && zoneTableView.exists
        && cancelButton.exists
    }
}
