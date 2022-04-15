//
//  ImageLoader.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik (HLB) on 11/04/2022.
//

import Foundation
import UIKit
import RxSwift

final class ImageLoader {
    
    private let imageCache = ImageCache()
    private let disposeBag = DisposeBag()
    
    func loadImageWithURLSession(from urlPath: String, completionHandler: @escaping (UIImage?)-> Void) {
        guard let url = URL(string: "\(Utils.baseUrl)\(urlPath)") else {
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
