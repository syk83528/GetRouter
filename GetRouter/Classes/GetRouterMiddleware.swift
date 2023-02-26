//
//  GetRouterMiddleware.swift
//  quick
//
//  Created by suyikun on 2023/2/25.
//

import Foundation

///// 路由中间件
//public protocol GetRouterMiddleware {
//    /// 优先级
//    var priority: Int { get }
//
//    /// 处理返回结果
//    /// - Returns: true: 允许通过 false: 禁止
//    func handler(routeName: GetRouterName, params: GetDict?) -> Bool
//
//    @available(iOS 13.0.0, *)
//    func handlerAsync(routeName: GetRouterName, params: GetDict?) async throws -> Bool
//}

open class GetRouterMiddleware {
    /// 优先级
    let priority: Int
    
    public init(priority: Int) {
        self.priority = priority
    }
    /// 处理返回结果
    /// - Returns: true: 允许通过 false: 禁止
    open func handler(routeName: GetRouterName, params: GetDict?) -> Bool { true }
    
    @available(iOS 13.0.0, *)
    /// 异步中间件, 注意如果想要在此出重定向路由,注意要回到mainThread
    /// - Parameter routeName: 路由名
    /// - Returns: true: 允许通过 false: 禁止
    open func handlerAsync(routeName: GetRouterName, params: GetDict?) async throws -> Bool { true }
}
