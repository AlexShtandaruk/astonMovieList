//
//  RouterTests.swift
//  MVP+UnitTests
//
//  Created by Alex Shtandaruk on 8.05.2023.
//

import XCTest
@testable import MVP_Unit

final class RouterTests: XCTestCase {
    
    var router: RouterPlaceProtocol!
    var navigationController: MockNavigationController!
    var assembly: AssemblyBuiler!

    override func setUpWithError() throws {
        navigationController = MockNavigationController()
        assembly = AssemblyBuiler()
        router = RouterPlace(
            navigationController: navigationController,
            assemblyBuilder: assembly
        )
    }

    override func tearDownWithError() throws {
        navigationController = nil
        assembly = nil
        router = nil
    }
    
    func testRouter() {
        router.showObjects(data: nil)
        let objectViewController = navigationController.presentedVC
        XCTAssertTrue(objectViewController is ObjectViewController)
    }
}
