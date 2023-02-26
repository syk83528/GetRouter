//
//  Router+Common.swift
//  GetRouter_Example
//
//  Created by suyikun on 2023/2/26.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import GetRouter

extension GetRouterName {
    /// 回到根路由 选择tab
    static let tabSelect: GetRouterName = "/common/tabSelect"
    static let test: GetRouterName = "/common/test"
    static let home1: GetRouterName = "/common/home1"
    static let home2: GetRouterName = "/common/home2"
    static let home3: GetRouterName = "/common/home3"
    static let home4: GetRouterName = "/common/home4"
}

/// 公共
struct GetRouterCommonHandler: GetRouterHandlerSource {
    var pages: [GetPage] = [
        GetPage(name: .test,
                action: { params in
                    TestHomePage().push()
                }),
        GetPage(name: .home1,
                middlewares: [
                    GetRouterMiddlewareLogin(priority: 1)
                ],
                action: { params in
                    TestHomePage().push()
                }),
        GetPage(name: .home2,
                middlewares: [
                    GetRouterMiddlewareLogin(priority: 1),
                    GetRouterMiddlewareMale(priority: 2),
                ],
                action: { params in
                    TestHomePage().push()
                }),
        GetPage(name: .home3,
                middlewares: [
                    GetRouterMiddlewareVip(priority: 1),
                ],
                action: { params in
                    TestHomePage().push()
                }),
        GetPage(name: .home4,
                middlewares: [
                    GetRouterMiddlewareLogin(priority: 1),
                    GetRouterMiddlewareVip(priority: 2),
                ],
                action: { params in
                    TestHomePage().push()
                }),
    ]
}
