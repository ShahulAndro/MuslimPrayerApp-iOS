//
//  UIImageView+Extension.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik (HLB) on 11/04/2022.
//

import Foundation
import UIKit

extension UIImageView {
    
    func load(urlString: String) {
        if let url = URL(string: urlString) {
            DispatchQueue.global(qos: .background).async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
    
}
