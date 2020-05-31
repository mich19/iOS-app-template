//
//  HTTPService.swift
//  iOS-app-template
//
//  Created by Michel Franco Téllez on 30/05/20.
//  Copyright © 2020 MichelFranco. All rights reserved.
//

import Foundation

protocol HTTPService {
    var host: String { get }
    var endPoint: String { get }
    var method: HTTPMethod { get }
    var extraHeaders: [String: String]? { get }
    var queryParams: [String: String]? { get }
    var body: Data? { get }
}

extension HTTPService {
    func url() -> URL? {
        return URL(string: "\(host)/\(endPoint)\(query() ?? "")")
    }
    
    func query() -> String? {
        let customAllowedSet =  CharacterSet(charactersIn:"!\"#%/<>@?+\\^`{|}'").inverted
        return queryParams?.reduce("?") { (lastQuery, queryParam) -> String in
            return "\(lastQuery)\(queryParam.key)=\(queryParam.value)&"
        }.addingPercentEncoding(withAllowedCharacters: customAllowedSet)
    }
}
