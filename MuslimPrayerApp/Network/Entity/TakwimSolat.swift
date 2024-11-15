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
//  TakwimSolat.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik on 05/04/2022.
//
//  Copyright 2022 Shahul Hameed Shaik
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
