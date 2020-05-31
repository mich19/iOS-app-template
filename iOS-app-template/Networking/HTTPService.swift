//
//  HTTPService.swift
//  iOS-app-template
//
//  Created by Michel Franco Téllez on 30/05/20.
//  Copyright © 2020 MichelFranco. All rights reserved.
//

import Foundation

protocol HTTPService {
    var url: String { get }
    var endPoint: String { get }
    var method: HTTPMethod { get }
    var extraHeaders: [String: Any]? { get }
    var query: String? { get }
    var body: Data? { get }
    var parameters: [String: Any]? { get }
}
