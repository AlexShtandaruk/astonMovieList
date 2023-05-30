//
//  CategoryPresenterTests.swift
//  MVP+UnitTests
//
//  Created by Alex Shtandaruk on 8.05.2023.
//

import XCTest
@testable import MVP_Unit

final class CategoryPresenterTests: XCTestCase {
    
    var view: MockCategoryView!
    var presenter: CategoryPresenter!
    var networkService: NetworkServiceProtocol!
    var router: RouterPlaceProtocol!
    var data = Place(success: false, time: "boo", data: nil)

    override func setUpWithError() throws {
        let navigationController = UINavigationController()
        let assemblyBuilder = AssemblyBuiler()
        router = RouterPlace(
            navigationController: navigationController,
            assemblyBuilder: assemblyBuilder
        )
    }

    override func tearDownWithError() throws {
        view = nil
        networkService = nil
        router = nil
        presenter = nil
    }
    
//    func testGetSuccessData() {
//        view = MockCategoryView()
//        networkService = MockNetworkService<Place>(data: data)
//        presenter = CategoryPresenter(
//            view: view,
//            networkService: networkService,
//            router: router
//        )
//        
//        var catchData: Place?
//        
//        networkService.getPlaceData { result in
//            switch result {
//            case .success(let data):
//                catchData = data
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//        
//        XCTAssertNotEqual(catchData?.success, true)
//        XCTAssertEqual(catchData?.time, data.time)
//    }
//    
//    func testGetFailureData() {
//        view = MockCategoryView()
//        networkService = MockNetworkService<Place>()
//        presenter = CategoryPresenter(
//            view: view,
//            networkService: networkService,
//            router: router
//        )
//        
//        var catchError: Error?
//        
//        networkService.getPlaceData { result in
//            switch result {
//            case .success( _):
//                break
//            case .failure(let error):
//                catchError = error
//            }
//        }
//        
//        XCTAssertNotNil(catchError)
//    }
}
