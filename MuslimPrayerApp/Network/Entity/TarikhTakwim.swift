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
//  TarikhTakwim.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik on 05/04/2022.
//

import Foundation

struct TarikhTakwim: Codable {
    var takwim: [String: String]?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        takwim = [String: String]()
        let subContainer = try container.nestedContainer(keyedBy: GenericCodingKeys.self, forKey: .takwim)
        for key in subContainer.allKeys {
            takwim?[key.stringValue] = try subContainer.decode(String.self, forKey: key)
        }
    }
}

struct GenericCodingKeys: CodingKey {
    var intValue: Int?
    var stringValue: String

    init?(intValue: Int) { self.intValue = intValue; self.stringValue = "\(intValue)" }
    init?(stringValue: String) { self.stringValue = stringValue }

    static func makeKey(name: String) -> GenericCodingKeys {
        return GenericCodingKeys(stringValue: name)!
    }
}
