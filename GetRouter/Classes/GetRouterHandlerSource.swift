//
//  GetRouterHandlerSource.swift
//  quick
//
//  Created by suyikun on 2023/2/26.
//

import Foundation

public struct GetPage {
    public var name: GetRouterName
    public var middlewares: [GetRouterMiddleware]
    public var action: ((GetDict?)->())?
    
    public init(name: GetRouterName, middlewares: [GetRouterMiddleware] = [], action: ( (GetDict?) -> Void)? = nil) {
        self.name = name
        self.middlewares = middlewares
        self.action = action
    }
}

public protocol GetRouterHandlerSource {
    var pages: [GetPage] { get set }
}
