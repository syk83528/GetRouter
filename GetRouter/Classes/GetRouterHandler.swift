//
//  GetRouterHandler.swift
//  quick
//
//  Created by suyikun on 2023/2/26.
//

import Foundation

struct GetRougerHandler {
    var subHandlers: [GetRouterHandlerSource] = []
    
    func handler(name: GetRouterName, params: GetDict?) {
        if #available(iOS 13, *) {
            Task.init {
                do {
                    for source in subHandlers {
                        for page in source.pages {
                            // 匹配到目标
                            guard page.name == name else {
                                continue
                            }
                            // 中间件拦截
                            for middleware in page.middlewares.sorted(by: { $0.priority < $1.priority }) {
                                
                                // 同步拦截
                                let allowSyncPass: Bool = middleware.handler(routeName: name, params: params)
                                // 异步拦截
                                let allowAsyncPass = try await middleware.handlerAsync(routeName: name, params: params)
                                
                                guard allowSyncPass,
                                      allowAsyncPass else {
                                    getRouterllog("中间件拦截")
                                    return
                                }
                            }
                            // 执行路由
                            DispatchQueue.main.async {
                                page.action?(params)
                            }
                        }
                    }
                    getRouterllog("路由无法被解析")
                } catch {
                    getRouterllog("路由执行失败")
                    getRouterllog(error.localizedDescription)
                }
            }
        } else {
            for source in subHandlers {
                for page in source.pages {
                    // 匹配到目标
                    guard page.name == name else {
                        continue
                    }
                    // 中间件拦截
                    for middleware in page.middlewares.sorted(by: { $0.priority < $1.priority }) {
                        
                        // 同步拦截
                        let allowSyncPass: Bool = middleware.handler(routeName: name, params: params)
                        
                        guard allowSyncPass else {
                            getRouterllog("中间件拦截")
                            return
                        }
                    }
                    // 执行路由
                    if Thread.isMainThread {
                        page.action?(params)
                    } else {
                        DispatchQueue.main.async {
                            page.action?(params)
                        }
                    }
                }
            }
        }
        
    }
    
}
