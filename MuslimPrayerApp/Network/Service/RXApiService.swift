//
//  RXApiService.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik (HLB) on 05/04/2022.
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
