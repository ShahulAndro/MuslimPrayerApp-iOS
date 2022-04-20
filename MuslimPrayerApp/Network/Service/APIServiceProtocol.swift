//
//  APIServiceProtocol.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik (HLB) on 16/04/2022.
//

import Foundation
import RxSwift

protocol APIServiceProtocol {
    var disposeBag: DisposeBag { get set }
    func performRequest<T: Codable>(apiRequest: APIRequest)-> Observable<T>
}
