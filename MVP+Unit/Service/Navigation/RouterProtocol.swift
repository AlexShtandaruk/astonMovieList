//
//  RouterProtocol.swift
//  MVP+Unit
//
//  Created by Alex Shtandaruk on 8.05.2023.
//

import UIKit

protocol RouterProtocol {
    
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}
