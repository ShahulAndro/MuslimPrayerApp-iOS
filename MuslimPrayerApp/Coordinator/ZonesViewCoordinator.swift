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
//  ZonesViewCoordinator.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik on 26/04/2022.
//
//  Copyright 2022 Shahul Hameed Shaik
//

import Foundation
import UIKit

class ZonesViewCoordinator: Coordinator {
    
    private let zonesViewVC: ZonesViewController
    
    private weak var viewController: UIViewController!
    
    private let delegate: ZonesViewControllerDelegate
    
    init(viewController: UIViewController, delegate: ZonesViewControllerDelegate) {
        self.viewController = viewController
        self.delegate = delegate
        zonesViewVC = ZonesViewController()
    }
    
    func start() {
        zonesViewVC.viewModel = ESolatViewModel()
        zonesViewVC.coordinator = self
        zonesViewVC.modalPresentationStyle = .popover
        viewController.present(zonesViewVC, animated: true, completion: nil)
    }
    
    func onDidSelect(row: (key: String, value: String)) {
        delegate.onDidSelect(row: row)
    }
    
    func stop() {
        zonesViewVC.dismiss(animated: true, completion: nil)
    }
}
