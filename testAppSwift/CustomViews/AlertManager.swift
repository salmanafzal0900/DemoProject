//
//  AlertManager.swift
//  testAppSwift
//
//  Created by Salman Afzal on 07/08/2024.
//

import UIKit

class AlertManager {
    static let shared = AlertManager()
    
    private init() {}
    
    func showAlert(on viewController: UIViewController, title: String, message: String, actionTitle: String = "OK", actionHandler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default) { _ in
            actionHandler?()
        }
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    
    // Function to show an alert with multiple actions
    func showAlertWithActions(on viewController: UIViewController, title: String, message: String, actions: [(title: String, style: UIAlertAction.Style, handler: (() -> Void)?)]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            let alertAction = UIAlertAction(title: action.title, style: action.style) { _ in
                action.handler?()
            }
            alert.addAction(alertAction)
        }
        viewController.present(alert, animated: true, completion: nil)
    }
}
