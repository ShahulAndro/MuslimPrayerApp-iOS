//
//  BaseXCTestCase.swift
//  MuslimPrayerAppUITests
//
//  Created by Shahul Hamed Shaik (HLB) on 23/04/2022.
//

import Foundation
import XCTest

class BaseXCTestCase: XCTestCase {
    
    var app: XCUIApplication!
    let device = XCUIDevice.shared

    override func setUp() {
        super.setUp()
        
        app = XCUIApplication()
        app.launch()
        
        device.orientation = .portrait
    }

    override func tearDown() {
        super.tearDown()
        
        app.terminate()
    }
    
}
