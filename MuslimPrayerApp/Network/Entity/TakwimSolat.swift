//
//  TakwimSolat.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik (HLB) on 05/04/2022.
//

import Foundation

struct TakwimSolat: BaseResponse {
    var hijri: String?
    var date: String?
    var day: String?
    var imsak: String?
    var fajr: String?
    var syuruk: String?
    var dhuhr: String?
    var asr: String?
    var maghrib: String?
    var isha: String?
    
    var serverTime: String?
    var dateType: String?
    var dateRequest: String?
    var status: String?
    var periodType: String?
    var lang: String?
    var zone: String?
    var bearing: String?
}
