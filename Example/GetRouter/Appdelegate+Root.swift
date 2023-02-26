//
//  Appdelegate+Root.swift
//  GetRouter_Example
//
//  Created by suyikun on 2023/2/26.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import RTNavigationController
import GetRouter

extension AppDelegate {
    func prepare() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return }
//        let nav = UINavigationController()
        let vc = ViewController()
        let nav = RTRootNavigationController(rootViewController: vc)
        window.rootViewController = nav
        window.backgroundColor = .white
        window.makeKeyAndVisible()
    }
    
    func prepareRouter() {
        GetRouter.config(nativeScheme: "native", routeNameKey: "ios_router")
        GetRouter.registerHandler(GetRouterCommonHandler())
        GetRouter.registerHandler(GetRouterTestHandler())
    }
}
