//
//  Router+Test.swift
//  GetRouter_Example
//
//  Created by suyikun on 2023/2/26.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import GetRouter

extension GetRouterName {
    static let test_a: GetRouterName = "/test/a"
    static let test_b: GetRouterName = "/test/b"
    static let test_c: GetRouterName = "/test/c"
    static let test_d: GetRouterName = "/test/d"
    static let test_e: GetRouterName = "/test/e"
    static let test_f: GetRouterName = "/test/f"
}

/// 公共
struct GetRouterTestHandler: GetRouterHandlerSource {
    var pages: [GetPage] = [
        GetPage(name: .test_a,
                action: { params in
                    getRouterllog("shuaiqi")
                }),
        GetPage(name: .test_b,
                action: { params in
                    getRouterllog("shuaiqi")
                }),
        GetPage(name: .test_c,
                action: { params in
                    getRouterllog("shuaiqi")
                }),
        GetPage(name: .test_d,
                action: { params in
                    getRouterllog("shuaiqi")
                }),
        GetPage(name: .test_e,
                action: { params in
                    getRouterllog("shuaiqi")
                }),
    ]
}
