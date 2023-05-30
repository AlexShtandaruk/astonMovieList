//
//  MockNetworkService.swift
//  MVP+UnitTests
//
//  Created by Alex Shtandaruk on 8.05.2023.
//

import Foundation
@testable import MVP_Unit

class MockNetworkService<T>: NetworkServiceProtocol {

    var data: T?

    init() { }

    convenience init(data: T?) {
        self.init()
        self.data = data
    }

    func getDataFromUrl<T>(url: URL, completion: @escaping BackendOperationHandler<T>) {
        if let data = data {
            completion(.success(data as? T))
        } else {
            let error = NSError(domain: "error getDotaData unit test", code: 0)
            completion(.failure(.decodeError(description: error.localizedDescription)))
        }
    }

    func getPlaceData(completion: @escaping BackendOperationHandler<Place>) {
        let url = URL(string: "")!
        getDataFromUrl(url: url, completion: completion)
    }
}

