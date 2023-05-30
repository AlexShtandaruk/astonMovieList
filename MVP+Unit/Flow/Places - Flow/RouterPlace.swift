//
//  RouterPlace.swift
//  MVP+Unit
//
//  Created by Alex Shtandaruk on 8.05.2023.
//

import UIKit

protocol RouterPlaceProtocol: RouterProtocol {
    
    func initialViewController()
    func showObjects(data: [Object]?)
    func popToRoot()
}

class RouterPlace: RouterPlaceProtocol {
    
    var navigationController: UINavigationController?
    
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let categoryViewController = assemblyBuilder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [categoryViewController]
        }
    }
    
    func showObjects(data: [Object]?) {
        if let navigationController = navigationController {
            guard let objectViewController = assemblyBuilder?.createObjectModule(data: data, router: self) else { return }
            navigationController.pushViewController(objectViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
}
