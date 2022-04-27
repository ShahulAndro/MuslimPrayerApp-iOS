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
//  PrayersViewControllerTests.swift
//  MuslimPrayerAppTests
//
//  Created by Shahul Hamed Shaik on 19/04/2022.
//

import XCTest


class PrayersViewControllerTests: XCTestCase {
    
    var vc: PrayersViewController!

    override func setUpWithError() throws {
        vc = PrayersViewController()
        vc.viewModel = ESolatViewModel()
        vc.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        vc = nil
    }
    
    func testViewDidLoad() throws {
        _ = try XCTUnwrap(vc.rootContentView, "Root content view not connected")
        _ = try XCTUnwrap(vc.headerView, "Header view not connected")
        _ = try XCTUnwrap(vc.prayerBGImageView, "Prayer BG ImageView not connected")
        _ = try XCTUnwrap(vc.settingsImageView, "Settings ImageView not connected")
        _ = try XCTUnwrap(vc.headerStackView, "Header StackView not connected")
        _ = try XCTUnwrap(vc.eDateLabel, "Gerogorian Date Label not connected")
        _ = try XCTUnwrap(vc.iDateLabel, "Islamic Calendar Date Label not connected")
        _ = try XCTUnwrap(vc.nextPrayerTimeLabel, "Next Prayer Time Label not connected")
        _ = try XCTUnwrap(vc.prayerTypeLabel, "Prayer Type Label not connected")
        _ = try XCTUnwrap(vc.prayerTimeLabel, "Prayer Time Label not connected")
        _ = try XCTUnwrap(vc.timeRemainingForPrayerView, "Time Remaining for prayer view not connected")
        _ = try XCTUnwrap(vc.hoursLabel, "Hours Label not connected")
        _ = try XCTUnwrap(vc.minsLabel, "Minitues Label not connected")
        _ = try XCTUnwrap(vc.secLabel, "Seconds Label not connected")
        _ = try XCTUnwrap(vc.zoneLabel, "Zone Label not connected")
        _ = try XCTUnwrap(vc.prayerDateSelectionView, "Prayer Date Selection View not connected")
        _ = try XCTUnwrap(vc.previousButton, "Previous Button not connected")
        _ = try XCTUnwrap(vc.islamicDateLabel, "Islamic Date Label not connected")
        _ = try XCTUnwrap(vc.nextButton, "Next Button not connected")
        _ = try XCTUnwrap(vc.prayerView, "Prayer View not connected")
        _ = try XCTUnwrap(vc.prayerTableView, "Prayer TableView not connected")
        _ = try XCTUnwrap(vc.loadingIndicator, "Loading Indicator not connected")
    }
    
    func testViewModelInit() throws {
        XCTAssertNotNil(vc.viewModel, "ESolatViewModel is not initialized")
    }

}
