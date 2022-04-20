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
//  MockRXApiService.swift
//  MuslimPrayerAppTests
//
//  Created by Shahul Hamed Shaik (HLB) on 16/04/2022.
//

import Foundation
import RxSwift

protocol RemoteClient {
    func response(request: URLRequest) -> Observable<(response: HTTPURLResponse, data: Data)>
}

class MockRXApiService: APIServiceProtocol, RemoteClient {
    
    var output: Any?
    var apiRequest: APIRequest?
    var disposeBag = DisposeBag()
    var verifyInput: ((APIRequest) -> Void)?
    
    func performRequest<T: Codable>(apiRequest: APIRequest)-> Observable<T> {
        return Observable.create { observer in
            if let data = self.output {
                observer.on(.next(data as! T))
            }
            
            observer.on(.completed)
            
            return Disposables.create()
        }
    }
    
    func response(request: URLRequest) -> Observable<(response: HTTPURLResponse, data: Data)> {
        return Observable.create { observer in
            if let data = self.output {
                observer.on(.next(data as! (response: HTTPURLResponse, data: Data)))
            }
            
            observer.on(.completed)
            
            return Disposables.create()
        }
    }
}
