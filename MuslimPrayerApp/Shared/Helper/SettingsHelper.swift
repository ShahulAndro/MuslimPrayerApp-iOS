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
//  SettingsHelper.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik on 15/04/2022.
//

import Foundation

struct SettingsHelper {
    
    static var mutaAllNotification: Bool {
        return UserDefaults.standard.bool(forKey: "mute_all_notifications")
    }
    
    static var muteImsakNotification: Bool {
        return UserDefaults.standard.bool(forKey: "imsak_notification")
    }
    
    static var muteFajrNotification: Bool {
        return UserDefaults.standard.bool(forKey: "fajr_notification")
    }
    
    static var muteSyurukNotification: Bool {
        return UserDefaults.standard.bool(forKey: "syuruk_notification")
    }
    
    static var muteDhuhrNotification: Bool {
        return UserDefaults.standard.bool(forKey: "dhuhr_notification")
    }
    
    static var muteAsarNotification: Bool {
        return UserDefaults.standard.bool(forKey: "asar_notification")
    }
    
    static var muteMagaribNotification: Bool {
        return UserDefaults.standard.bool(forKey: "magrib_notification")
    }
    
    static var muteIshaNotification: Bool {
        return UserDefaults.standard.bool(forKey: "isha_notification")
    }
    
    static func muteNotificationFor(_ prayerType: String)-> Bool {
        if prayerType == PrayerType.Imsak.rawValue && muteImsakNotification {
            return true
        }
        
        if prayerType == PrayerType.Fajr.rawValue && muteFajrNotification {
            return true
        }
        
        if prayerType == PrayerType.Syuruk.rawValue && muteSyurukNotification {
            return true
        }
        
        if prayerType == PrayerType.Dhuhr.rawValue && muteDhuhrNotification {
            return true
        }
        
        if prayerType == PrayerType.Asar.rawValue && muteAsarNotification {
            return true
        }
        
        if prayerType == PrayerType.Maghrib.rawValue && muteMagaribNotification {
            return true
        }
        
        if prayerType == PrayerType.Isha.rawValue && muteIshaNotification {
            return true
        }
        
        return false
    }
    
}
