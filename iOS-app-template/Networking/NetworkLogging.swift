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
        print("===================== HTTP Request ====================\n")
        print("\(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")\n")
        print("Headers:")
        request.allHTTPHeaderFields?.forEach{ (header) in
            print("\(header.key) \(header.value)")
        }
        if let body = request.httpBody {
            print("\nBody:")
            print(String(data: body, encoding: .utf8) ?? "")
        }
        print("=======================================================")
    }
    
    static func log(response: URLResponse?, withData data: Data?, andError error: Error?) {
        print("==================== HTTP Response ====================\n")
        if let response = response as? HTTPURLResponse {
            print("\(response.statusCode) \(response.url?.absoluteString ?? "")\n")
            print("Headers:")
            response.allHeaderFields.forEach{ (header) in
                print("\(header.key) \(header.value)")
            }
        }
        if let error = error {
            print("\n\(error.localizedDescription)")
        } else if let data = data {
//            let json = try? JSONSerialization.jsonObject(with: data, options: [])
//
//            if let jsonDictionary = json as? NSDictionary {
//                print("\nBody:\n\(jsonDictionary)")
//            } else {
                print("\nBody:")
                print(String(data: data, encoding: .utf8) ?? "")
//            }
        }
        print("=======================================================")
    }
}
