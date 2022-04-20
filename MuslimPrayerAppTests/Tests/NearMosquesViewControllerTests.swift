//
//  NearMosquesViewControllerTests.swift
//  MuslimPrayerAppTests
//
//  Created by Shahul Hamed Shaik (HLB) on 20/04/2022.
//

import XCTest

class NearMosquesViewControllerTests: XCTestCase {
    
    var vc: NearMosquesViewController!

    override func setUpWithError() throws {
        vc = NearMosquesViewController()
    }

    override func tearDownWithError() throws {
        vc = nil
    }

    func testViewDidLoad() throws {
        _ = try XCTUnwrap(vc.mosquesTableView, "Mosques TableView not connected")
    }

}
