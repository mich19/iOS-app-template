//
//  HTTPClient.swift
//  iOS-app-template
//
//  Created by Michel Franco Téllez on 30/05/20.
//  Copyright © 2020 MichelFranco. All rights reserved.
//

import Foundation

typealias RawResult = (HTTPRawResult) -> Void
typealias DataResult = (HTTPDataResult) -> Void
typealias ObjectResult<T: Codable> = (HTTPObjectResult<T>) -> Void
typealias ArrayResult<T: Codable> = (HTTPArrayResult<T>) -> Void

protocol HTTPClientProtocol {
    func excecute(service: HTTPService, completion: @escaping RawResult)
    func excecute(service: HTTPService, completion: @escaping DataResult)
    func excecute<T>(service: HTTPService, completion: @escaping ObjectResult<T>)
    func excecute<T>(service: HTTPService, completion: @escaping ArrayResult<T>)
}

class HTTPClient {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    private func dataTask(urlRequest: URLRequest) {
        let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                
            } else {
                
            }
        }
        dataTask.resume()
    }
}

extension HTTPClient: HTTPClientProtocol {
    func excecute(service: HTTPService, completion: @escaping RawResult) {
        
    }
    
    func excecute(service: HTTPService, completion: @escaping DataResult) {
        
    }
    
    func excecute<T>(service: HTTPService, completion: @escaping (HTTPObjectResult<T>) -> Void) where T : Decodable, T : Encodable {
        
    }
    
    func excecute<T>(service: HTTPService, completion: @escaping (HTTPArrayResult<T>) -> Void) where T : Decodable, T : Encodable {
        
    }
}
