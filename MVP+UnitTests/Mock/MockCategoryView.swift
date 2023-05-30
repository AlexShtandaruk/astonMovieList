//
//  MockCategoryView.swift
//  MVP+UnitTests
//
//  Created by Alex Shtandaruk on 8.05.2023.
//

import Foundation
@testable import MVP_Unit

class MockCategoryView: CategoryViewProtocol {
    
    func success() {}
    func failure(error: MVP_Unit.BackendError) {}
}
