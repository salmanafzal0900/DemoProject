//
//  AppDelegate.swift
//  testAppSwift
//
//  Created by Salman Afzal on 05/08/2024.
//

import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Create and set the root view controller
        let rootViewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    
    
    
}

