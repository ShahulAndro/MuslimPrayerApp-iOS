//
//  UserDefaultHelper.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik (HLB) on 26/04/2022.
//
//  Copyright 2022 Shahul Hameed Shaik
//

import Foundation

struct UserDefaultHelper {
    
    enum UserDefaultKeys: String {
        case zoneCode
        case zoneValue
        case currentDisplayDate
        case dalyNotificationScheudle
    }
    
    static func setSelectedZone(code: String, value: String) {
        UserDefaults.standard.set(code, forKey:  UserDefaultKeys.zoneCode.rawValue)
        UserDefaults.standard.set(value, forKey:  UserDefaultKeys.zoneValue.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func selectedZone()-> String? {
        return UserDefaults.standard.string(forKey: UserDefaultKeys.zoneCode.rawValue)
    }
    
    static func selectedZoneValue()-> String? {
        return UserDefaults.standard.string(forKey: UserDefaultKeys.zoneValue.rawValue)
    }
    
    static func setCurrentDisplayDate(currentDisplayDate: String) {
        UserDefaults.standard.set(currentDisplayDate, forKey:  UserDefaultKeys.currentDisplayDate.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func currentDisplayDate()-> String? {
        return UserDefaults.standard.string(forKey: UserDefaultKeys.currentDisplayDate.rawValue)
    }
    
    static func updateDalyNotificationScheudle(_ value: Bool) {
        UserDefaults.standard.set(value, forKey:  UserDefaultKeys.dalyNotificationScheudle.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func dalyNotificationScheudle()-> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultKeys.dalyNotificationScheudle.rawValue)
    }
}
