//
//  NetworkLogging.swift
//  iOS-app-template
//
//  Created by Michel Franco Téllez on 31/05/20.
//  Copyright © 2020 MichelFranco. All rights reserved.
//

import Foundation

class NetworLogging {
    static func log(request: URLRequest) {
        debugPrint("===================== HTTP Request ====================")
        debugPrint("\(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")")
        debugPrint("Headers:")
        request.allHTTPHeaderFields?.forEach{ (header) in
            debugPrint("\(header.key) \(header.value)")
        }
        if let body = request.httpBody {
            debugPrint("Body:")
            debugPrint("\(String(data: body, encoding: .utf8) ?? "")")
        }
        debugPrint("=======================================================")
    }
    
    static func log(response: URLResponse?, withData data: Data?, andError error: Error?) {
        debugPrint("==================== HTTP Response ====================")
        if let response = response as? HTTPURLResponse {
            debugPrint("\(response.statusCode) \(response.url?.absoluteString ?? "")")
            response.allHeaderFields.forEach{ (header) in
                debugPrint("\(header.key) \(header.value)")
            }
        }
        if let error = error {
            debugPrint("\(error.localizedDescription)")
        } else if let data = data {
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            
            if let jsonDictionary = json as? NSDictionary {
                debugPrint("Body: \(jsonDictionary)")
            } else {
                debugPrint("Body: \(String(data: data, encoding: .utf8) ?? "")")
            }
        }
        debugPrint("=======================================================")
    }
}
