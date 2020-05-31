//
//  Data+Ext.swift
//  iOS-app-template
//
//  Created by Michel Franco Téllez on 31/05/20.
//  Copyright © 2020 MichelFranco. All rights reserved.
//

import Foundation

extension Data {
    /// Decodes into `Decodable` object the given `Data` object
    func toObject<T: Decodable>(_ type: T.Type) -> T? {
        let decoder = JSONDecoder()
        let object = try? decoder.decode(type, from: self)
        return object
    }
    
    func toObjectArray<T: Decodable>(_ type: T.Type) -> [T]? {
        let decoder = JSONDecoder()
        let object = try? decoder.decode([T].self, from: self)
        return object
    }
    
    func toDictionary() -> [String: Any]? {
        return try? JSONSerialization.jsonObject(with: self, options: []) as? [String: Any]
    }
}
