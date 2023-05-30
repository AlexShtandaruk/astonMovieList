//
//  AlertEvent.swift
//  MVP+Unit
//
//  Created by Alex Shtandaruk on 8.05.2023.
//

import UIKit

enum AlertEvent {
    case failureNetwork
}

enum AlertAuth {
    case emptyLogin
    case emptyPassword
    case invalidLogin
    case invalidPassword
    case unknownedLogin
    case incorrectPassword
}

final class AlertService {
    
    let alert = CAlertController()
    
    func alertForUser(
        with type: AlertEvent,
        view: UIViewController,
        text: String?,
        code: Int
    ) {
        switch type {
        case .failureNetwork:
            alert.openAlert(
                viewController: view,
                title: "Alert",
                message: "Failure - " + (text ?? String()) + ". StatusCode: - \(code)",
                alertStyle: .alert,
                actionTitles: [ "Cancel" ],
                actionStyles: [ .cancel ],
                actions: [ { _ in print("failureNetwork")} ]
            )
        }
    }
}
