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
//  Utils.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik on 05/04/2022.
//

import Foundation
import UIKit

struct Utils {
    
    static let islamicCalendarMonths = [ "01": "Muharram",
                                         "02": "Safar",
                                         "03": "Rabi'ulawal",
                                         "04": "Rabi'ulakhir",
                                         "05": "Jamadilawal",
                                         "06": "Jamadilakhir",
                                         "07": "Rejab",
                                         "08": "Sya'ban",
                                         "09": "Ramadhan",
                                         "10": "Shawwal",
                                         "11": "Zulkaedah",
                                         "12": "Zulhijjah" ]
    
    static let prayerNames = ["miladi" : "Miladi Date",
                              "hijri" : "Hijri Date",
                              "Day" : "Day",
                              "Imsak" : "Imsak",
                              "Fajr" : "Subuh",
                              "Syuruk" : "Syuruk",
                              "Dhuhr" : "Zohor",
                              "Asar" : "Asar",
                              "Maghrib" : "Maghrib",
                              "Isha" : "Isyak"]
    
    static func getHijriDate(_ date: String)-> String {
        let dateComponents = date.components(separatedBy: "-")
        return "\(dateComponents[2]) \(islamicCalendarMonths[dateComponents[1]] ?? "") \(dateComponents[0]) Hijri"
    }
    
    static func getGregorianDate()-> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "DD MMMM YYYY"
        return "\(dateFormat.string(from: Date())) Miladi"
    }
    
    static func isToday(_ dateString: String)-> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        let currentDate = dateFormatter.date(from: dateString)
        if let date = currentDate {
            return Calendar.current.isDateInToday(date)
        }
        
        return false
    }
    
    static func isDateInTomorrow(_ dateString: String)-> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        let currentDate = dateFormatter.date(from: dateString)
        if let date = currentDate {
            return Calendar.current.isDateInTomorrow(date)
        }
        
        return false
    }
    
    static func getNearestPrayerWith(_ prayerTime: TakwimSolat)-> (prayerType: String, prayerTime: String) {
        let imsakTimes = Utils.getDateComponentsFrom(timein24: prayerTime.imsak ?? "")
        let fajrTimes = Utils.getDateComponentsFrom(timein24: prayerTime.fajr ?? "")
        let syurukTimes = Utils.getDateComponentsFrom(timein24: prayerTime.syuruk ?? "")
        let dhuhrTimes = Utils.getDateComponentsFrom(timein24: prayerTime.dhuhr ?? "")
        let asrTimes = Utils.getDateComponentsFrom(timein24: prayerTime.asr ?? "")
        let maghribTimes = Utils.getDateComponentsFrom(timein24: prayerTime.maghrib ?? "")
        let ishaTimes = Utils.getDateComponentsFrom(timein24: prayerTime.isha ?? "")
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "HH:mm:ss"
        let currentDateComponents = Utils.getDateComponentsFrom(timein24: dateFormat.string(from: Date()))
        
        let now = Date()
        let calendar = Calendar.current
        
        if calendar.date(byAdding: currentDateComponents, to: now)! <= calendar.date(byAdding: imsakTimes, to: now)! || !isToday(prayerTime.date ?? "") {
            return (PrayerType.Imsak.rawValue, prayerTime.imsak!)
        }
        
        if calendar.date(byAdding: currentDateComponents, to: now)! <= calendar.date(byAdding: fajrTimes, to: now)! {
            return (PrayerType.Fajr.rawValue, prayerTime.fajr!)
        }
        
        if calendar.date(byAdding: currentDateComponents, to: now)! <= calendar.date(byAdding: syurukTimes, to: now)! {
            return (PrayerType.Syuruk.rawValue, prayerTime.syuruk!)
        }
        
        if calendar.date(byAdding: currentDateComponents, to: now)! <= calendar.date(byAdding: dhuhrTimes, to: now)! {
            return (PrayerType.Dhuhr.rawValue, prayerTime.dhuhr!)
        }
        
        if calendar.date(byAdding: currentDateComponents, to: now)! <= calendar.date(byAdding: asrTimes, to: now)! {
            return (PrayerType.Asar.rawValue, prayerTime.asr!)
        }
        
        if calendar.date(byAdding: currentDateComponents, to: now)! <= calendar.date(byAdding: maghribTimes, to: now)! {
            return (PrayerType.Maghrib.rawValue, prayerTime.maghrib!)
        }
        
        if calendar.date(byAdding: currentDateComponents, to: now)! <= calendar.date(byAdding: ishaTimes, to: now)! {
            return (PrayerType.Isha.rawValue, prayerTime.isha!)
        }
        
        return ("", "")
    }
    
    static func getDateComponentsFrom(timein24: String)-> DateComponents {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        
        let componets = Calendar.current.dateComponents([.hour, .minute, .second], from: formatter.date(from: timein24)!)
        return componets
    }
    
    static func getHoursComponents(hoursTimein24: String)-> [Int?] {
        let componets = hoursTimein24.components(separatedBy: ":").map{ Int($0) }
        return componets
    }
    
    static func getDateFormatForApiFromddMMMyyyy(dateString: String, type: PrayerTimeType)-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        var date = Date()
        if type == .Next {
            date = dateFormatter.date(from: dateString)!.dayAfter
        } else {
            date = dateFormatter.date(from: dateString)!.dayBefore
        }
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    static func showAlertForRequestSettings(vc: UIViewController) {
        let alertController = UIAlertController(title: "Settings", message: "Please modify your settings", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Open Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        vc.present(alertController, animated: true, completion: nil)
    }
}
