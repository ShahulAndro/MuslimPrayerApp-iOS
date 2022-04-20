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
