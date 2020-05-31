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
    private enum CoreResult {
        case success(result: Data, status: Int)
        case failure(error: Error)
    }
    
    private typealias CoreResultResponse = (CoreResult) -> Void
    
    private let urlSession: URLSession
    private let headers = [
        "Content-Type": "application/json",
        "Connection": "Keep-Alive",
        "User-Agent": "" // TODO: add functionality to get device name
    ]
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    private func makeUrlRequest(service: HTTPService) -> URLRequest {
        let request = NSMutableURLRequest()
        
        request.url = service.url()
        
        headers.forEach { header in
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        service.extraHeaders?.forEach { header in
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        request.httpMethod = service.method.httpValue
        
        if let body = service.body {
            request.httpBody = body
        }
        
        return request as URLRequest
    }
    
    private func excecuteDataTask(urlRequest: URLRequest, completion: @escaping CoreResultResponse) {
        NetworLogging.log(request: urlRequest)
        let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            NetworLogging.log(response: response, withData: data, andError: error)
            if let error = error {
                completion(.failure(error: error))
            } else {
                guard let data = data,
                let response = response as? HTTPURLResponse else {
                    let error = NSError(domain: urlRequest.url?.host ?? "", code: -1, userInfo: [NSLocalizedDescriptionKey : "Unable to get any response data"]) as Error
                    completion(.failure(error: error))
                    return
                }
                completion(.success(result: data, status: response.statusCode))
            }
        }
        dataTask.resume()
    }
}

extension HTTPClient: HTTPClientProtocol {
    func excecute(service: HTTPService, completion: @escaping RawResult) {
        excecuteDataTask(urlRequest: makeUrlRequest(service: service)) { (coreResult) in
            switch coreResult {
            case let .success(result: result, status: status):
                guard let response = result.toDictionary() else {
                    completion(.failure(error: "Unable to parse response data into key/value format".toError()))
                    return
                }
                completion(.success(httpStatus: status, response: response))
            case .failure(error: let error):
                completion(.failure(error: error))
            }
        }
    }
    
    func excecute(service: HTTPService, completion: @escaping DataResult) {
        excecuteDataTask(urlRequest: makeUrlRequest(service: service)) { (coreResult) in
            switch coreResult {
            case let .success(result: result, status: status):
                completion(.success(httpStatus: status, response: result))
            case .failure(error: let error):
                completion(.failure(error: error))
            }
        }
    }
    
    func excecute<T>(service: HTTPService, completion: @escaping (HTTPObjectResult<T>) -> Void) where T: Codable {
        excecuteDataTask(urlRequest: makeUrlRequest(service: service)) { (coreResult) in
            switch coreResult {
            case let .success(result: result, status: status):
                guard let response = result.toObject(T.self) else {
                    completion(.failure(error: "Unable to parse response data into \(T.self)".toError()))
                    return
                }
                completion(.success(httpStatus: status, response: response))
            case .failure(error: let error):
                completion(.failure(error: error))
            }
        }
    }
    
    func excecute<T>(service: HTTPService, completion: @escaping (HTTPArrayResult<T>) -> Void) where T: Codable {
        excecuteDataTask(urlRequest: makeUrlRequest(service: service)) { (coreResult) in
            switch coreResult {
            case let .success(result: result, status: status):
                guard let response = result.toObjectArray(T.self) else {
                    completion(.failure(error: "Unable to parse response data into \([T].self)".toError()))
                    return
                }
                completion(.success(httpStatus: status, response: response))
            case .failure(error: let error):
                completion(.failure(error: error))
            }
        }
    }
}
