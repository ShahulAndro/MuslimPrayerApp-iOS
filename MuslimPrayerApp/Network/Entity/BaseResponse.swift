//
//  BaseResponse.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik (HLB) on 06/04/2022.
//

import Foundation

protocol BaseResponse: Codable {
    var serverTime: String? { get }
    var dateType: String? { get }
    var dateRequest: String? { get }
    var status: String? { get }
    var periodType: String? { get }
    var lang: String? { get }
    var zone: String? { get }
    var bearing: String? { get }
}
