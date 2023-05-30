//
//  Backend+RequestType.swift
//  MVP+Unit
//
//  Created by Alex Shtandaruk on 21.05.2023.
//

import Foundation

enum RequestType {
    case get
    case post
    case put
    case delete
    
    var value: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        case .delete:
            return "DELETE"
        }
    }
}
