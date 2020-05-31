//
//  HTTPMethod.swift
//  iOS-app-template
//
//  Created by Michel Franco Téllez on 30/05/20.
//  Copyright © 2020 MichelFranco. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case post
    case get
    case put
    case delete
    
    var httpValue: String {
        return rawValue.uppercased()
    }
}
