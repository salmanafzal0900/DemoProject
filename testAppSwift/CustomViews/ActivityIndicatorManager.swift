//
//  ActivityIndicatorManager.swift
//  testAppSwift
//
//  Created by Salman Afzal on 07/08/2024.
//

import UIKit

class ActivityIndicatorManager {
    static let shared = ActivityIndicatorManager()
    
    private init() {}
    
    private var activityIndicator: UIActivityIndicatorView?
    
    func showLoader(in view: UIView) {
        if activityIndicator == nil {
            if #available(iOS 13.0, *) {
                activityIndicator = UIActivityIndicatorView(style: .large)
            }
            activityIndicator?.center = view.center
            activityIndicator?.hidesWhenStopped = true
            view.addSubview(activityIndicator!)
        }
        DispatchQueue.main.async {
            self.activityIndicator?.startAnimating()
        }
    }
    
    func hideLoader() {
        
        DispatchQueue.main.async {
            self.activityIndicator?.stopAnimating()
        }
      
    }
}
