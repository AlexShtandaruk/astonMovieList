//
//  Group.swift
//  MVP+Unit
//
//  Created by Alex Shtandaruk on 8.05.2023.
//

import Foundation

enum GroupType: String, CodingKey, CaseIterable {
    
    case all
    case danger = "danger-10"
    case violet = "violet-10"
    case warning = "warning-10"
    case cyan = "cyan-10"
    case info = "info-10"
    case primary = "primary-10"
    case success = "success-10"
}
