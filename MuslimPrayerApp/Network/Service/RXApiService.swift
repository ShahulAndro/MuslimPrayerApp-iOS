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
//  RXApiService.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik on 05/04/2022.
//

import Foundation
import RxSwift
import RxCocoa

private enum APIError: Error {
    case invalidResponse(URLResponse?)
    case invalidJSON(Error)
}

struct RXApiService {
    let disposeBag = DisposeBag()
    
    func fetch<T: Codable>(apiRequest: APIRequest)-> Observable<T> {
        let request = apiRequest.request()
        return URLSession.shared.rx.response(request: request)
            .map { result -> Data in
                guard result.response.statusCode == 200 else {
                    throw APIError.invalidResponse(result.response)
                }
                print(result)
                return result.data
            }
            .map { data in
                do {
                    let responseStringData = String(data: data, encoding: .utf8)
                    print("Response Json:\n\(String(describing: responseStringData))")
                    
                    let decodeObject = try JSONDecoder().decode(T.self, from: data)
                    return decodeObject
                } catch let error {
                    throw APIError.invalidJSON(error)
                }
            }
            .observe(on: MainScheduler.instance)
            .asObservable()
    }
}
