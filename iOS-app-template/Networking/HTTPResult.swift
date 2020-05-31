//
//  HTTPResult.swift
//  iOS-app-template
//
//  Created by Michel Franco Téllez on 30/05/20.
//  Copyright © 2020 MichelFranco. All rights reserved.
//

import Foundation

enum HTTPRawResult {
    case success(httpStatus: Int, response: [String: Any])
    case failure(error: Error)
}

enum HTTPDataResult {
    case success(httpStatus: Int, response: Data)
    case failure(error: Error)
}

enum HTTPObjectResult<T: Codable> {
    case success(httpStatus: Int, response: T)
    case failure(error: Error)
}

enum HTTPArrayResult<T: Codable> {
    case success(httpStatus: Int, response: [T])
    case failure(error: Error)
}
