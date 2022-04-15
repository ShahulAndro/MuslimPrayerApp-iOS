//
//  ImageCacheType.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik (HLB) on 11/04/2022.
//

import Foundation
import UIKit

protocol ImageCacheType: AnyObject {
    
    func image(for url: URL)-> UIImage?
    
    func insertImage(_ image: UIImage?, for url: URL)
    
    func removeImage(for url: URL)
    
    func removeAllImages()
    
    subscript(_url: URL)-> UIImage? { get set }
}
