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
//  PrayersViewCoordinator.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik on 26/04/2022.
//
//  Copyright 2022 Shahul Hameed Shaik
//

import Foundation
import UIKit

class PrayersViewCoordinator: Coordinator {
    
    var prayersVC: PrayersViewController!
    
    init() {
        prayersVC = PrayersViewController()
        prayersVC.tabBarItem.title = "Prayers"
        prayersVC.tabBarItem.accessibilityIdentifier = "Prayers"
        prayersVC.tabBarItem.image = UIImage(systemName: "p.square.fill")
        prayersVC.tabBarItem.selectedImage = UIImage(systemName: "p.square")
    }
    
    func start() {
        prayersVC.viewModel = ESolatViewModel()
        prayersVC.coordinator = self
    }
    
    func showZones() {
        let zonesCoordinator = ZonesViewCoordinator(viewController: prayersVC, delegate: self)
        zonesCoordinator.start()
    }
    
    func showSettings() {
        let settingsCoordinator = SettingsViewCoordinator(viewController: prayersVC)
        settingsCoordinator.start()
    }
    
    func stop() {
        prayersVC.dismiss(animated: true, completion: nil)
    }
    
}

extension PrayersViewCoordinator: ZonesViewControllerDelegate {
    func onDidSelect(row: (key: String, value: String)) {
        prayersVC.onDidSelect(row: row)
    }
    
    
}
