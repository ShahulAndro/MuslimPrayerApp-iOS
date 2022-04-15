//
//  APIRequest.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik (HLB) on 05/04/2022.
//

import Foundation

enum RequestType: String {
    case GET
    case POST
}

struct APIRequest {
    
    let apiURL = "https://www.e-solat.gov.my/index.php?r=esolatApi/"
    
    var parameters: [String: String] = [:]
    
    var queryParameterItems: [String: String] = [:]
    
    var method: RequestType = RequestType.GET
    
    var path: String = ""
    
    var requestPayload: [String: String] = [:]
    
    private let boundary: String = UUID().uuidString
    private var httpBody = NSMutableData()
    
    init(method: RequestType = RequestType.GET, path: String = "", queryParameterItems: [String: String] = [:], parameters: [String: String] = [:], requestPayload: [String: String] = [:]) {
        self.method = method
        self.path = path
        self.queryParameterItems = queryParameterItems
        self.parameters = parameters
        self.requestPayload = requestPayload
    }
    
    func addTextFields() {
        httpBody.append(textFormFields().data(using: .utf8)!)
    }
    
    private func textFormFields() -> String {
        var fieldString = "Content-Type: multipart/form-data; boundary=------\(boundary)\r\n"
        fieldString += "\r\n"
        for (key, value) in requestPayload {
            fieldString += "------\(boundary)\r\n"
            fieldString += "Content-Disposition: form-data; name=\"\(key)\"\r\n"
            fieldString += "\r\n"
            fieldString += "\(value)\r\n"
        }
        fieldString += "------\(boundary)--\r\n"

        return fieldString
    }
    
    func getPostString() -> String {
        var data = [String]()
        for(key, value) in requestPayload
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
    
    func request() -> URLRequest {
        var urlString = "\(apiURL)\(path)"
        //Append parameters if any
        queryParameterItems.forEach({key, value in
            urlString.append("&\(key)=\(value)")
        })

        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if !requestPayload.isEmpty && method == RequestType.POST {
//            addTextFields()
//            request.httpBody = httpBody as Data
            let postString = self.getPostString()
            request.httpBody = postString.data(using: .utf8)

        } else {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return request
    }
}
