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
//  SettingsScreenTests.swift
//  MuslimPrayerAppUITests
//
//  Created by Shahul Hamed Shaik (HLB) on 20/04/2022.
//

import XCTest

class SettingsScreenTests: BaseXCTestCase {
    
    func testSetttingsPageLoad() {
        let prayersViewScreen = PrayersViewScreen(app: app)
        XCTAssertTrue(prayersViewScreen.verifyPageLoad())
        
        prayersViewScreen.tapOnSettings().waitFor(seconds: 3)
        
        let settings =  SettingsScreen(app: app)
        XCTAssertTrue(settings.verifySettingsPageLoad())
    }
    
    func testNotificationSwiftchOnOff() {
        let prayersViewScreen = PrayersViewScreen(app: app)
        XCTAssertTrue(prayersViewScreen.verifyPageLoad())
        
        prayersViewScreen.tapOnSettings().waitFor(seconds: 3)
        
        let settings =  SettingsScreen(app: app)
        XCTAssertTrue(settings.verifySettingsPageLoad())
        
        let asarSwitchValue = settings.getAsarSwitchCurrentValue()
        settings.tapOnAsarSwitch().waitFor(seconds: 3)
        XCTAssertTrue(settings.veryAsarSwitchChange(asarSwitchValue))
        
        let fajrSwitchValue = settings.getFajrSwitchCurrentValue()
        settings.tapOnFajrSwitch().waitFor(seconds: 3)
        XCTAssertTrue(settings.veryFajrSwitchChange(fajrSwitchValue))
        
        let ishaSwitchValue = settings.getIshaSwitchCurrentValue()
        settings.tapOnIshaSwitch().waitFor(seconds: 3)
        XCTAssertTrue(settings.veryIshaSwitchChange(ishaSwitchValue))
        
        let dhuhrSwitchValue = settings.getDhuhrSwitchCurrentValue()
        settings.tapOnDhuhrSwitch().waitFor(seconds: 3)
        XCTAssertTrue(settings.veryDhuhrSwitchChange(dhuhrSwitchValue))
        
        let imsakSwitchValue = settings.getImsakSwitchCurrentValue()
        settings.tapOnImsakSwitch().waitFor(seconds: 3)
        XCTAssertTrue(settings.veryImsakSwitchChange(imsakSwitchValue))
        
        let magribSwitchValue = settings.getMagribSwitchCurrentValue()
        settings.tapOnMagribSwitch().waitFor(seconds: 3)
        XCTAssertTrue(settings.veryMagribSwitchChange(magribSwitchValue))
        
        let syurukSwitchValue = settings.getSyurukSwitchCurrentValue()
        settings.tapOnSyurukSwitch().waitFor(seconds: 3)
        XCTAssertTrue(settings.verySyurukSwitchChange(syurukSwitchValue))
    }
    
    func testNotificationSwiftchOnOffPersistance() {
        let prayersViewScreen = PrayersViewScreen(app: app)
        XCTAssertTrue(prayersViewScreen.verifyPageLoad())
        
        prayersViewScreen.tapOnSettings().waitFor(seconds: 3)
        
        let settings =  SettingsScreen(app: app)
        XCTAssertTrue(settings.verifySettingsPageLoad())
        
        let asarSwitchValue = settings.getAsarSwitchCurrentValue()
        settings.tapOnAsarSwitch().waitFor(seconds: 3)
        XCTAssertTrue(settings.veryAsarSwitchChange(asarSwitchValue))
        
        let fajrSwitchValue = settings.getFajrSwitchCurrentValue()
        settings.tapOnFajrSwitch().waitFor(seconds: 3)
        XCTAssertTrue(settings.veryFajrSwitchChange(fajrSwitchValue))
        
        let ishaSwitchValue = settings.getIshaSwitchCurrentValue()
        settings.tapOnIshaSwitch().waitFor(seconds: 3)
        XCTAssertTrue(settings.veryIshaSwitchChange(ishaSwitchValue))
        
        let dhuhrSwitchValue = settings.getDhuhrSwitchCurrentValue()
        settings.tapOnDhuhrSwitch().waitFor(seconds: 3)
        XCTAssertTrue(settings.veryDhuhrSwitchChange(dhuhrSwitchValue))
        
        let imsakSwitchValue = settings.getImsakSwitchCurrentValue()
        settings.tapOnImsakSwitch().waitFor(seconds: 3)
        XCTAssertTrue(settings.veryImsakSwitchChange(imsakSwitchValue))
        
        let magribSwitchValue = settings.getMagribSwitchCurrentValue()
        settings.tapOnMagribSwitch().waitFor(seconds: 3)
        XCTAssertTrue(settings.veryMagribSwitchChange(magribSwitchValue))
        
        let syurukSwitchValue = settings.getSyurukSwitchCurrentValue()
        settings.tapOnSyurukSwitch().waitFor(seconds: 3)
        XCTAssertTrue(settings.verySyurukSwitchChange(syurukSwitchValue))
        
        settings.tapOnCancel()
        
        XCTAssertTrue(prayersViewScreen.verifyPageLoad())
        prayersViewScreen.tapOnSettings().waitFor(seconds: 3)
        
        
        XCTAssertTrue(settings.verifySettingsPageLoad())
        XCTAssertTrue(settings.veryAsarSwitchChange(asarSwitchValue))
        XCTAssertTrue(settings.veryFajrSwitchChange(fajrSwitchValue))
        XCTAssertTrue(settings.veryIshaSwitchChange(ishaSwitchValue))
        XCTAssertTrue(settings.veryDhuhrSwitchChange(dhuhrSwitchValue))
        XCTAssertTrue(settings.veryImsakSwitchChange(imsakSwitchValue))
        XCTAssertTrue(settings.veryMagribSwitchChange(magribSwitchValue))
        XCTAssertTrue(settings.veryMagribSwitchChange(magribSwitchValue))
        XCTAssertTrue(settings.verySyurukSwitchChange(syurukSwitchValue))
    }
    
    func testSetttingsNavigtion() {
        let prayersViewScreen = PrayersViewScreen(app: app)
        XCTAssertTrue(prayersViewScreen.verifyPageLoad())
        
        prayersViewScreen.tapOnSettings().waitFor(seconds: 3)
        
        let settings =  SettingsScreen(app: app)
        XCTAssertTrue(settings.verifySettingsPageLoad())
        
        settings.tapOnCancel()
        
        XCTAssertTrue(prayersViewScreen.verifyPageLoad())
    }
    
}
