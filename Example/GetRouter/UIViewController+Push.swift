//
//  UIViewController+Push.swift
//  GetRouter_Example
//
//  Created by suyikun on 2023/2/26.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation

extension UIViewController {
    static var current: UIViewController? {
        guard let window = (UIApplication.shared.delegate as? AppDelegate)?.window, let r = window.rootViewController else {
            return nil
        }
        
        var root:UIViewController? = r
        while root!.presentedViewController != nil {
            root = root!.presentedViewController
        }
        
        if let nav = root! as? UINavigationController,
           let visible = nav.visibleViewController
        {
            if let tab = visible as? UITabBarController {
                // selc
                return tab.selectedViewController
            } else if false {
                // 考虑PageController
            } else {
                return visible
            }
        }
        return root
    }
    
    func push() {
        UIViewController.current?.navigationController?.pushViewController(self, animated: true)
    }
}
