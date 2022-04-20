//
//  ZonesViewControllerTests.swift
//  MuslimPrayerAppTests
//
//  Created by Shahul Hamed Shaik (HLB) on 20/04/2022.
//

import XCTest

class ZonesViewControllerTests: XCTestCase {
    
    var vc: ZonesViewController!

    override func setUpWithError() throws {
        vc = ZonesViewController()
    }

    override func tearDownWithError() throws {
        vc = nil
    }

    func testViewDidLoad() throws {
        _ = try XCTUnwrap(vc.chooseZonePlaceHolderLabel, "Choose Zone Place holder Lable not connected")
        _ = try XCTUnwrap(vc.zoneTableView, "Zone TableView not connected")
    }

}
