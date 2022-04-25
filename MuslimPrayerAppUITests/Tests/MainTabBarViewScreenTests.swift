//
//  MainTabBarViewScreenTests.swift
//  MuslimPrayerAppUITests
//
//  Created by Shahul Hamed Shaik (HLB) on 23/04/2022.
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
