//
//  String+Ext.swift
//  iOS-app-template
//
//  Created by Michel Franco Téllez on 31/05/20.
//  Copyright © 2020 MichelFranco. All rights reserved.
//

import Foundation

extension String {
    /// Builds an `Error` object with the given `String` as `localizedDescription` parametter.
    func toError() -> Error {
        return NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: self]) as Error
    }
}
