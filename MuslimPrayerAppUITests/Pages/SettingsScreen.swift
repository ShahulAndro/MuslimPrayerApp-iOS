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
//  SettingsScreen.swift
//  MuslimPrayerAppUITests
//
//  Created by Shahul Hamed Shaik (HLB) on 20/04/2022.
//

import Foundation
import XCTest

class SettingsScreen {
    
    let app: XCUIApplication
    let mainStackView: XCUIElement
    let muteAllSwitch: XCUIElement
    let imsakSwitch: XCUIElement
    let fajrSwitch: XCUIElement
    let syurukSwitch: XCUIElement
    let dhuhrSwitch: XCUIElement
    let asarSwitch: XCUIElement
    let magribSwitch: XCUIElement
    let ishaSwitch: XCUIElement
    let cancelButton: XCUIElement
    
    init(app: XCUIApplication) {
        self.app = app
        self.mainStackView = app.otherElements["mainStackView"]
        self.muteAllSwitch = app.switches["muteAllSwitch"]
        self.imsakSwitch = app.switches["imsakSwitch"]
        self.fajrSwitch = app.switches["fajrSwitch"]
        self.syurukSwitch = app.switches["syurukSwitch"]
        self.dhuhrSwitch = app.switches["dhuhrSwitch"]
        self.asarSwitch = app.switches["asarSwitch"]
        self.magribSwitch = app.switches["magribSwitch"]
        self.ishaSwitch = app.switches["ishaSwitch"]
        self.cancelButton = app.buttons["cancelButton"]
    }
    
    func tapOnCancel() {
        cancelButton.tap()
    }
    
    func getMuteAllSwitchCurrentValue()-> Bool {
        return muteAllSwitch.switchCurrentValue
    }
    
    func tapOnMuteAllSwitch() {
        muteAllSwitch.tap()
    }
    
    func veryMuteAllSwitchChange(_ value: Bool)-> Bool {
        return muteAllSwitch.switchCurrentValue != value
    }
    
    func getImsakSwitchCurrentValue()-> Bool {
        return imsakSwitch.switchCurrentValue
    }
    
    func tapOnImsakSwitch() {
        imsakSwitch.tap()
    }
    
    func veryImsakSwitchChange(_ value: Bool)-> Bool {
        return imsakSwitch.switchCurrentValue != value
    }
    
    func getFajrSwitchCurrentValue()-> Bool {
        return fajrSwitch.switchCurrentValue
    }
    
    func tapOnFajrSwitch() {
        fajrSwitch.tap()
    }
    
    func veryFajrSwitchChange(_ value: Bool)-> Bool {
        return fajrSwitch.switchCurrentValue != value
    }
    
    func getSyurukSwitchCurrentValue()-> Bool {
        return syurukSwitch.switchCurrentValue
    }
    
    func tapOnSyurukSwitch() {
        syurukSwitch.tap()
    }
    
    func verySyurukSwitchChange(_ value: Bool)-> Bool {
        return syurukSwitch.switchCurrentValue != value
    }
    
    func getDhuhrSwitchCurrentValue()-> Bool {
        return dhuhrSwitch.switchCurrentValue
    }
    
    func tapOnDhuhrSwitch() {
        dhuhrSwitch.tap()
    }
    
    func veryDhuhrSwitchChange(_ value: Bool)-> Bool {
        return dhuhrSwitch.switchCurrentValue != value
    }
    
    func getAsarSwitchCurrentValue()-> Bool {
        return asarSwitch.switchCurrentValue
    }
    
    func tapOnAsarSwitch() {
        asarSwitch.tap()
    }
    
    func veryAsarSwitchChange(_ value: Bool)-> Bool {
        return asarSwitch.switchCurrentValue != value
    }
    
    func getMagribSwitchCurrentValue()-> Bool {
        return magribSwitch.switchCurrentValue
    }
    
    func tapOnMagribSwitch() {
        magribSwitch.tap()
    }
    
    func veryMagribSwitchChange(_ value: Bool)-> Bool {
        return magribSwitch.switchCurrentValue != value
    }
    
    func getIshaSwitchCurrentValue()-> Bool {
        return ishaSwitch.switchCurrentValue
    }
    
    func tapOnIshaSwitch() {
        ishaSwitch.tap()
    }
    
    func veryIshaSwitchChange(_ value: Bool)-> Bool {
        return ishaSwitch.switchCurrentValue != value
    }
    
    func verifySettingsPageLoad()-> Bool {
        return mainStackView.exists
        && muteAllSwitch.exists
        && imsakSwitch.exists
        && fajrSwitch.exists
        && syurukSwitch.exists
        && dhuhrSwitch.exists
        && asarSwitch.exists
        && magribSwitch.exists
        && ishaSwitch.exists
    }
    
}