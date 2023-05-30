//
//  FontType.swift
//  MVP+Unit
//
//  Created by Alex Shtandaruk on 8.05.2023.
//

import Foundation

enum FontType {
    
    case morserattRegular
    case monserattBold
    
    var value: String {
        switch self {
        case .morserattRegular:
            return "Montserrat-Regular"
        case .monserattBold:
            return "Montserrat-Bold"
        }
    }
}
