//
//  TakwimSolatData.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik (HLB) on 06/04/2022.
//

import Foundation

struct TakwimSolatData: BaseResponse {
    var serverTime: String?
    
    var dateType: String?
    
    var dateRequest: String?
    
    var status: String?
    
    var periodType: String?
    
    var lang: String?
    
    var zone: String?
    
    var bearing: String?
    
    var prayerTime: [TakwimSolat]?
}
