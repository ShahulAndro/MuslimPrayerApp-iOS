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
//  SettingsViewCoordinator.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik on 26/04/2022.
//
//  Copyright 2022 Shahul Hameed Shaik
//

import Foundation
import UIKit


class SettingsViewCoordinator: Coordinator {
    
    private let settingsVC: SettingsViewController
    
    private weak var viewController: UIViewController!
    
    init(viewController: UIViewController) {
        self.viewController = viewController
        settingsVC = SettingsViewController()
    }
    
    func start() {
        settingsVC.modalPresentationStyle = .popover
        settingsVC.coordinator = self
        viewController.present(settingsVC, animated: true, completion: nil)
    }
    
    func stop() {
        settingsVC.dismiss(animated: true, completion: nil)
    }
}
