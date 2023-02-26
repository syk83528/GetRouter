//
//  GetRouterMiddlewareFemale.swift
//  GetRouter_Example
//
//  Created by suyikun on 2023/2/26.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import GetRouter

class GetRouterMiddlewareFemale: GetRouterMiddleware {
    override func handler(routeName: GetRouterName, params: GetDict?) -> Bool {
        let isFemale = Bool.random()
        if !isFemale {
            print("不是女生")
        }
        return isFemale
    }
}
