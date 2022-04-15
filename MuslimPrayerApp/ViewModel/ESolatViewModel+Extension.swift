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
//  ESolatViewModel+Extension.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik on 16/04/2022.
//

import Foundation

extension ESolatViewModel {
    
    func loadAllImages(data: BGImageByPrayerTimeData) {
        
        let dispatchQueue = DispatchQueue.global(qos: .utility)
        let dispathGroup = DispatchGroup()
        
        dispathGroup.enter()
        dispatchQueue.async(group: dispathGroup) {
            if let bg_imagePath = data.data?.bg_images1 {
                self.imageLoader.loadImageWithURLSession(from: bg_imagePath, completionHandler: { (image) in
                    defer { dispathGroup.leave() }
                    if let image = image {
                        self.images.append(image)
                    }
                })
            }
        }
        
        dispathGroup.enter()
        dispatchQueue.async(group: dispathGroup) {
            if let bg_imagePath = data.data?.bg_images2 {
                self.imageLoader.loadImageWithURLSession(from: bg_imagePath, completionHandler: { (image) in
                    
                    defer { dispathGroup.leave() }
                    
                    if let image = image {
                        self.images.append(image)
                    }
                })
            }
        }
        
        dispathGroup.enter()
        dispatchQueue.async(group: dispathGroup) {
            if let bg_imagePath = data.data?.bg_images3 {
                self.imageLoader.loadImageWithURLSession(from: bg_imagePath, completionHandler: { (image) in
                    defer { dispathGroup.leave() }
                    
                    if let image = image {
                        self.images.append(image)
                    }
                })
            }
        }
        
        dispathGroup.enter()
        dispatchQueue.async(group: dispathGroup) {
            if let bg_imagePath = data.data?.bg_images4 {
                self.imageLoader.loadImageWithURLSession(from: bg_imagePath, completionHandler: { (image) in
                    defer { dispathGroup.leave() }
                    if let image = image {
                        self.images.append(image)
                    }
                })
            }
        }
        
        dispathGroup.enter()
        dispatchQueue.async(group: dispathGroup) {
            if let bg_imagePath = data.data?.bg_images5 {
                self.imageLoader.loadImageWithURLSession(from: bg_imagePath, completionHandler: { (image) in
                    defer { dispathGroup.leave() }
                    if let image = image {
                        self.images.append(image)
                    }
                })
            }
        }
        
        dispathGroup.notify(queue: DispatchQueue.global()) {
            self.bgImagePrayerImages.onNext(self.images)
        }
    }
    
    func downloadImagesWithRx(data: BGImageByPrayerTimeData) {
        if let bg_images1 = data.data?.bg_images1, let url = URL(string: "\(String(describing: APIRequest.baseUrl))\(bg_images1)") {
            self.imageLoader.loadImageWithRX(from: url)
        }
        
        if let bg_images2 = data.data?.bg_images2, let url = URL(string: "\(String(describing: APIRequest.baseUrl))\(bg_images2)") {
            self.imageLoader.loadImageWithRX(from: url)
        }
        
        if let bg_images3 = data.data?.bg_images3, let url = URL(string: "\(String(describing: APIRequest.baseUrl))\(bg_images3)") {
            self.imageLoader.loadImageWithRX(from: url)
        }
        
        if let bg_images4 = data.data?.bg_images4, let url = URL(string: "\(String(describing: APIRequest.baseUrl))\(bg_images4)") {
            self.imageLoader.loadImageWithRX(from: url)
        }
        
        if let bg_images5 = data.data?.bg_images5, let url = URL(string: "\(String(describing: APIRequest.baseUrl))\(bg_images5)") {
            self.imageLoader.loadImageWithRX(from: url)
        }
    }
    
}
