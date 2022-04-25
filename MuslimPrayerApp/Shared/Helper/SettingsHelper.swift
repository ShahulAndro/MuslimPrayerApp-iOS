//
//  SettingsHelper.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik (HLB) on 15/04/2022.
//

import Foundation

struct SettingsHelper {
    
    static var mutaAllNotification: Bool {
        return UserDefaults.standard.bool(forKey: "mute_all_notifications")
    }
    
    static var imsakNotification: Bool {
        return UserDefaults.standard.bool(forKey: "imsak_notification")
    }
    
    static var fajrNotification: Bool {
        return UserDefaults.standard.bool(forKey: "fajr_notification")
    }
    
    static var syurukNotification: Bool {
        return UserDefaults.standard.bool(forKey: "syuruk_notification")
    }
    
    static var dhuhrNotification: Bool {
        return UserDefaults.standard.bool(forKey: "dhuhr_notification")
    }
    
    static var asarNotification: Bool {
        return UserDefaults.standard.bool(forKey: "asar_notification")
    }
    
    static var magaribNotification: Bool {
        return UserDefaults.standard.bool(forKey: "magrib_notification")
    }
    
    static var ishaNotification: Bool {
        return UserDefaults.standard.bool(forKey: "isha_notification")
    }
    
    static func isAllowedNotification(_ prayerType: String)-> Bool {
        if prayerType == PrayerType.Imsak.rawValue && imsakNotification {
            return true
        }
        
        if prayerType == PrayerType.Fajr.rawValue && fajrNotification {
            return true
        }
        
        if prayerType == PrayerType.Syuruk.rawValue && syurukNotification {
            return true
        }
        
        if prayerType == PrayerType.Dhuhr.rawValue && dhuhrNotification {
            return true
        }
        
        if prayerType == PrayerType.Asar.rawValue && asarNotification {
            return true
        }
        
        if prayerType == PrayerType.Maghrib.rawValue && magaribNotification {
            return true
        }
        
        if prayerType == PrayerType.Isha.rawValue && ishaNotification {
            return true
        }
        
        return false
    }
    
}
