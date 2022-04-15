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
//  SettingsViewController.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik on 15/04/2022.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var mainStackView: UIStackView!
    
    @IBOutlet weak var muteAllSwitch: UISwitch!
    @IBOutlet weak var imsakSwitch: UISwitch!
    @IBOutlet weak var fajrSwitch: UISwitch!
    @IBOutlet weak var syurukSwitch: UISwitch!
    @IBOutlet weak var dhuhrSwitch: UISwitch!
    @IBOutlet weak var asarSwitch: UISwitch!
    @IBOutlet weak var magribSwitch: UISwitch!
    @IBOutlet weak var ishaSwitch: UISwitch!
    
    private var isUpdateFromApp = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UserDefaults.standard.register(defaults: [String: Any]())
        NotificationCenter.default.addObserver(self, selector: #selector(SettingsViewController.onValueChanged), name: UserDefaults.didChangeNotification, object: nil)
        updateValues()
        
    }

    @IBAction func tapOnCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func isToggleSwitchOn(_ sender: Any) {
        guard let tag = (sender as? UISwitch)?.tag else {
            return
        }
        
        isUpdateFromApp = true
        
        switch tag {
        case 1: UserDefaults.standard.set(true, forKey: "mute_all_notifications"); isUpdateFromApp = false
        case 2: UserDefaults.standard.set(true, forKey: "imsak_notification"); isUpdateFromApp = false
        case 3: UserDefaults.standard.set(true, forKey: "fajr_notification"); isUpdateFromApp = false
        case 4: UserDefaults.standard.set(true, forKey: "syuruk_notification"); isUpdateFromApp = false
        case 5: UserDefaults.standard.set(true, forKey: "dhuhr_notification"); isUpdateFromApp = false
        case 6: UserDefaults.standard.set(true, forKey: "asar_notification"); isUpdateFromApp = false
        case 7: UserDefaults.standard.set(true, forKey: "magrib_notification"); isUpdateFromApp = false
        case 8: UserDefaults.standard.set(true, forKey: "isha_notification"); isUpdateFromApp = false
        default: print("Nothing found to update")
        }
    }
    
    @objc func onValueChanged() {
        if isUpdateFromApp { return }
        
        updateValues()
    }
    
    func updateValues() {
        muteAllSwitch.isOn = UserDefaults.standard.bool(forKey: "mute_all_notifications")
        imsakSwitch.isOn = UserDefaults.standard.bool(forKey: "imsak_notification")
        fajrSwitch.isOn = UserDefaults.standard.bool(forKey: "fajr_notification")
        syurukSwitch.isOn = UserDefaults.standard.bool(forKey: "syuruk_notification")
        dhuhrSwitch.isOn = UserDefaults.standard.bool(forKey: "dhuhr_notification")
        asarSwitch.isOn = UserDefaults.standard.bool(forKey: "asar_notification")
        magribSwitch.isOn = UserDefaults.standard.bool(forKey: "magrib_notification")
        ishaSwitch.isOn = UserDefaults.standard.bool(forKey: "isha_notification")
    }
        
    
}
