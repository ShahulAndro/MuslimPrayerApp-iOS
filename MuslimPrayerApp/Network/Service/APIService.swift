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
//  APIService.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik on 05/04/2022.
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
