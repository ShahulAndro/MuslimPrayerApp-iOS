//
//  MainTabBarViewController.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik (HLB) on 06/04/2022.
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
