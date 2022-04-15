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
//  MainTabBarViewController.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik on 06/04/2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCommon()
    }

}


extension MainTabBarViewController {
    
    private func initCommon() {
        let prayersViewController = PrayersViewController()
        prayersViewController.tabBarItem.title = "Prayers"
        prayersViewController.tabBarItem.image = UIImage(systemName: "p.square.fill")
        prayersViewController.tabBarItem.selectedImage = UIImage(systemName: "p.square")
        
        let nearMosquesViewController = NearMosquesViewController()
        nearMosquesViewController.tabBarItem.title = "Find Mosques"
        nearMosquesViewController.tabBarItem.image = UIImage(systemName: "f.square.fill")
        nearMosquesViewController.tabBarItem.selectedImage = UIImage(systemName: "f.square")
        
        self.viewControllers = [prayersViewController, nearMosquesViewController]
    }
}
