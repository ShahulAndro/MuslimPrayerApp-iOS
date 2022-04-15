//
//  APIService.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik (HLB) on 05/04/2022.
//

import Foundation

protocol APIServiceProtocol {
    
}

struct APIService: APIServiceProtocol {
    
    func dataRequest<T: Codable>(url: String, objectType: T.Type, completion: @escaping (T?, Error?)-> Void) {
        let dataURL = URL(string: url)!
        let request = URLRequest(url: dataURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            guard let response = response as? HTTPURLResponse else {
                completion(nil, error)
                return
            }

            if let error = error {
                let error = NSError(domain: error.localizedDescription, code: response.statusCode, userInfo: response.allHeaderFields as? [String: Any])
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(objectType.self, from: data)
                completion(decodedObject, nil)
            } catch let error {
                let error = NSError(domain: error.localizedDescription, code: response.statusCode, userInfo: response.allHeaderFields as? [String: Any])
                completion(nil, error)
            }
        })
        
        task.resume()
    }
}
