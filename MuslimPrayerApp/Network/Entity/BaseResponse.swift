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
//  BaseResponse.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik on 06/04/2022.
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