//
//  UILabel+Extension.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik (HLB) on 13/04/2022.
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
