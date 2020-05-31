//
//  Codable+Ext.swift
//  iOS-app-template
//
//  Created by Michel Franco Téllez on 31/05/20.
//  Copyright © 2020 MichelFranco. All rights reserved.
//

import Foundation

// MARK: - Encodable extension
extension Encodable {
    
    /// Transforms into JSON Data represetation the given Encodable object
    func toRequestBodyData() -> Data? {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(self)
        return data
    }
}

// MARK: - Decodable extension
extension Decodable { }
