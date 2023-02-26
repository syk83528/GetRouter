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
}

/// 公共
struct GetRouterCommonHandler: GetRouterHandlerSource {
    var pages: [GetPage] = [
        GetPage(name: .tabSelect,
                action: { params in
                    getRouterllog("shuaiqi")
                }),
    ]
}
