//
//  String+Extension.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik (HLB) on 15/04/2022.
//

import Foundation

extension String {
    
    var escapedStringForURL: String? {
        if !self.containsWhitespace {
            return self
        }
        
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    var containsWhitespace:Bool  {
        return rangeOfCharacter(from: .whitespaces) != nil
    }
    
}
