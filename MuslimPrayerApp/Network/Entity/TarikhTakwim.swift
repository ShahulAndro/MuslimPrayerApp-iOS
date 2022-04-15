//
//  TarikhTakwim.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik (HLB) on 05/04/2022.
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
