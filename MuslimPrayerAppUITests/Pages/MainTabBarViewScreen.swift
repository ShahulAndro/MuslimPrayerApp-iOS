//
//  MainTabBarViewScreen.swift
//  MuslimPrayerAppUITests
//
//  Created by Shahul Hamed Shaik (HLB) on 21/04/2022.
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
        return prayerTabItem.exists
        && findMosquesTabItem.exists
    }
    
}
