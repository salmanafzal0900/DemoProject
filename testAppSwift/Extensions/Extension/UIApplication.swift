//
//  UIApplication.swift
//  talkMD-International-Provider
//
//  Created by Hasnain Jafri on 1/27/21.
//  Copyright © 2021 Ahtazaz. All rights reserved.
//

import UIKit

extension UIApplication {
    class var statusBarBackgroundColor: UIColor? {
        get {
            return (shared.value(forKey: "statusBar") as? UIView)?.backgroundColor
        } set {
            (shared.value(forKey: "statusBar") as? UIView)?.backgroundColor = newValue
        }
    }
}

extension UIApplication {
    func topMostViewController() -> UIViewController? {
        return self.keyWindow?.rootViewController?.topMostViewController()
    }
}
