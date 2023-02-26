//
//  GetRouterMiddlewareMale.swift
//  GetRouter_Example
//
//  Created by suyikun on 2023/2/26.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import GetRouter

class GetRouterMiddlewareMale: GetRouterMiddleware {
    override func handler(routeName: GetRouterName, params: GetDict?) -> Bool {
        let isMale = Bool.random()
        if !isMale {
            print("不是男生")
        }
        return isMale
    }
}
