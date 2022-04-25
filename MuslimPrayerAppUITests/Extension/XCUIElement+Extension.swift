//
//  XCUIElement+Extension.swift
//  MuslimPrayerAppUITests
//
//  Created by Shahul Hamed Shaik (HLB) on 23/04/2022.
//

import Foundation
import XCTest

extension XCUIElement {
    
    var isOn: Bool {
        return (self.value as? String).map { $0 == "1" } ?? false
    }
    
    var switchCurrentValue: Bool {
        return (self.value as? String).map { $0 == "1" } ?? false
    }
    
}
