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
//  PushService.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik on 14/04/2022.
//

import Foundation
import UserNotifications
import UIKit
import AVFoundation

//MARK: - UNUserNotificationCenterDelegate

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        if notification.request.identifier == "getLatestSolatInfo" {
            viewModel.fetchTakwimSolat()
            return
        }
        
        if SettingsHelper.mutaAllNotification {
            return
        }
        
        let userInfo = notification.request.content.userInfo
        if let prayerType = userInfo["prayerType"] as? String, !SettingsHelper.isAllowedNotification(prayerType) {
            return
        }
        
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        UIApplication.shared.applicationIconBadgeNumber = 0
        playAzan()
        completionHandler()
    }
    
}

//MARK: - Local PushNotification Configuration

extension AppDelegate {
    
    func requestAuthorization(completionHandler: @escaping (_ success: Bool)-> ()) {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (sucess, error) in
            if let error = error {
                print("Notification Center request authorization Error:\(error)")
            }
            
            completionHandler(sucess)
        }
    }
    
    func checkNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings() { (notificationSetting) in
            let status = notificationSetting.authorizationStatus
            
            switch status {
            case .notDetermined:
                self.requestAuthorization() { (success) in
                    guard success else { return }
                    
//                    self.scheduleLocalNotification()
                }
                break
            case .denied:
                print("Application Not Allowed to Display Notifications")
                //TODO: - show alert
            case .authorized:
//                self.scheduleLocalNotification()
                break
            case .provisional:
                break
            case .ephemeral:
                break
                
            default:
                print("Unknown Notification Settings:\(status)")
            }
            
        }
    }
    
    func scheduleLocalNotifications(solatData: TakwimSolat) {
        removeAllPrayerPendingNotificationRequests()
        
        scheduleUserNotificationWithPrayerType(PrayerType.Imsak.rawValue, solatData.imsak, solatData.date)
        scheduleUserNotificationWithPrayerType(PrayerType.Fajr.rawValue, solatData.fajr, solatData.date)
        scheduleUserNotificationWithPrayerType(PrayerType.Syuruk.rawValue, solatData.syuruk, solatData.date)
        scheduleUserNotificationWithPrayerType(PrayerType.Dhuhr.rawValue, solatData.dhuhr, solatData.date)
        scheduleUserNotificationWithPrayerType(PrayerType.Asar.rawValue, solatData.asr, solatData.date)
        scheduleUserNotificationWithPrayerType(PrayerType.Maghrib.rawValue, solatData.maghrib, solatData.date)
        scheduleUserNotificationWithPrayerType(PrayerType.Isha.rawValue, solatData.isha, solatData.date)
    }
    
    func removeAllPendingLocalNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    func removeAllPrayerPendingNotificationRequests() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [PrayerType.Imsak.rawValue, PrayerType.Fajr.rawValue, PrayerType.Syuruk.rawValue, PrayerType.Dhuhr.rawValue, PrayerType.Asar.rawValue, PrayerType.Maghrib.rawValue, PrayerType.Isha.rawValue])
    }
    
    func removeDailySchedulePendingNotificationRequests() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["getLatestSolatInfo"])
    }
    
    func scheduleUserNotificationWithPrayerType(_ prayerType: String, _ prayerTime: String?, _ dateString: String?) {
        
        guard let prayerTime = prayerTime, let dateString = dateString else {
            return
        }

        
        let content = UNMutableNotificationContent()
        content.title = "Prayer"
        content.subtitle = "\(prayerType) - \(prayerTime)"
        content.body = "View prayers times, Tap for full Azan."
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "azan_short.mp3"))
        content.userInfo = ["prayerType": prayerType, "prayerTime": prayerTime]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        
        let calendar = Calendar.current
        let dateComponents = (!dateString.isEmpty && !Utils.isToday(dateString)) ? calendar.dateComponents([.day, .hour, .minute, .second], from: dateFormatter.date(from: prayerTime)!) : calendar.dateComponents([.hour, .minute, .second], from: dateFormatter.date(from: prayerTime)!)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: prayerType, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error) in
            if let error = error {
                print("ScheduleLocalNotification Failed, reason: \(error.localizedDescription)")
            }
        })
    }
    
    func scheduleDialyNotificationToGetLatestPrayerData() {
        removeDailySchedulePendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "ESolat"
        content.body = ""
        content.sound = nil
        
        var datComp = DateComponents()
        datComp.hour = 00
        datComp.minute = 01
        let trigger = UNCalendarNotificationTrigger(dateMatching: datComp, repeats: true)
        let request = UNNotificationRequest(identifier: "getLatestSolatInfo", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error : Error?) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            UserDefaultHelper.updateDalyNotificationScheudle(true)
        }
    }
    
}


//MARK: - Viewmodel bindings

extension AppDelegate {
    
    func setupBinding() {
        viewModel
            .takwimSolatData
            .bind(onNext: {[weak self] (takwimSolatData) in
                if let solatInfo = takwimSolatData.prayerTime?.first {
                    self?.scheduleLocalNotifications(solatData: solatInfo)
                }
            })
            .disposed(by: disposeBag)
    }
    
}


//MARK: - AVAudioPlayer for play full Azan

extension AppDelegate {
    
    func configureAV() throws {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)
    }
    
    func playAzan() {
        guard let url = Bundle.main.url(forResource: "azan_full", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = audioPlayer else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}
