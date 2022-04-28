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
//  UILabel+Extension.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik on 13/04/2022.
//
//  Copyright 2022 Shahul Hameed Shaik
//

import Foundation
import UIKit

extension UILabel {
    
    var isTruncated: Bool {
        
        guard let labelText = text else {
            return false
        }
        
        let labelTextSize = (labelText as NSString).boundingRect(
            with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font as UIFont], context: nil).size
        
        return labelTextSize.height > bounds.size.height
    }
    
    func marquee() {
        if isTruncated {
            DispatchQueue.main.async(execute: {
                UIView.animate(withDuration: 10.0, delay: 1, options: ([.repeat]), animations: { () -> Void in
                    self.center = CGPoint(x: 0 - self.bounds.size.width / 2, y: self.center.y)
                }, completion:  nil)
            })
        }
    }
}
