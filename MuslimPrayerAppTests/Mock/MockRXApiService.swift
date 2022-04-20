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
