//
//  MockNavigationController.swift
//  MVP+UnitTests
//
//  Created by Alex Shtandaruk on 8.05.2023.
//

import UIKit
@testable import MVP_Unit

class MockNavigationController: UINavigationController {
    
    var presentedVC: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.presentedVC = viewController
    }
}
 
