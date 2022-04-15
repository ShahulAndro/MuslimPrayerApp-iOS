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
//  ImageLoader.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik on 11/04/2022.
//

import Foundation
import UIKit
import RxSwift

final class ImageLoader {
    
    private let imageCache = ImageCache()
    private let disposeBag = DisposeBag()
    
    func loadImageWithURLSession(from urlPath: String, completionHandler: @escaping (UIImage?)-> Void) {
        guard let url = URL(string: "\(APIRequest.baseUrl)\(urlPath)") else {
            completionHandler(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data else { completionHandler(nil); return }
            
            let image = UIImage(data: data)
            self?.imageCache.insertImage(image, for: url)
            print(data)
            completionHandler(image)
        }
        
        task.resume()
    }
    
    func loadImageWithRX(from url: URL) {
        URLSession.shared.rx.response(request: URLRequest(url: url))
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                self?.imageCache.insertImage(UIImage(data: data.data), for: url)
                print(data.data)
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
}
