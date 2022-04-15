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
//  BGImageByPrayerTime.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik on 05/04/2022.
//

import Foundation

struct BGImageByPrayerTime: Codable {
    var bg_id: String?
    var bg_set: String?
    var bg_images1: String?
    var bg_images2: String?
    var bg_images3: String?
    var bg_images4: String?
    var bg_images5: String?
    var created_by: String?
    var updated_by: String?
    var created_dt: String?
    var updated_dt: String?
}
