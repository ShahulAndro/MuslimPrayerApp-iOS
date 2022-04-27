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
//  APIRequest.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik on 05/04/2022.
//

import Foundation

enum RequestType: String {
    case GET
    case POST
}

struct APIRequest {

    static let baseUrl = "https://www.e-solat.gov.my"
    static let masjidImagesBaseUrl = "https://masjid.islam.gov.my/images/masjid/"
    static let apiURL = "https://www.e-solat.gov.my/index.php?r=esolatApi/"
    static let pathSirimTime = "SirimTime"
    static let pathTakwimSolat = "TakwimSolat"
    static let pathBgImageByPrayertime = "BgImageByPrayertime"
    static let pathNearestMosque = "nearestMosque"
    
    private var path: String = ""
    private var method: RequestType = RequestType.GET
    private let boundary: String = UUID().uuidString
    private var parameters: [String: String] = [:]
    private var queryParameterItems: [String: String] = [:]
    private var requestPayload: [String: String] = [:]
    private var httpBody = NSMutableData()
    
    init(method: RequestType = RequestType.GET, path: String = "", queryParameterItems: [String: String] = [:], parameters: [String: String] = [:], requestPayload: [String: String] = [:]) {
        self.method = method
        self.path = path
        self.queryParameterItems = queryParameterItems
        self.parameters = parameters
        self.requestPayload = requestPayload
    }
    
    func getPostString() -> String {
        var data = [String]()
        for(key, value) in requestPayload {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
    
    func request() -> URLRequest {
        var urlString = "\(APIRequest.apiURL)\(path)"
        queryParameterItems.forEach({key, value in
            urlString.append("&\(key)=\(value)")
        })

        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if method == RequestType.POST && !requestPayload.isEmpty {
            let postString = self.getPostString()
            request.httpBody = postString.data(using: .utf8)
        } else {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return request
    }
}
