# GetRouter

[![CI Status](https://img.shields.io/travis/suyikun/GetRouter.svg?style=flat)](https://travis-ci.org/suyikun/GetRouter)
[![Version](https://img.shields.io/cocoapods/v/GetRouter.svg?style=flat)](https://cocoapods.org/pods/GetRouter)
[![License](https://img.shields.io/cocoapods/l/GetRouter.svg?style=flat)](https://cocoapods.org/pods/GetRouter)
[![Platform](https://img.shields.io/cocoapods/p/GetRouter.svg?style=flat)](https://cocoapods.org/pods/GetRouter)

## Installation

```ruby
// Podfile:
pod 'GetRouter'

// 终端中:
pod install --repo-update
```
## 很纯粹的路由组件
提供一个无侵入的路由解析组件,本组件不涉及跳转操作,只用来解析路由,匹配路由,权限拦截.
文件查看顺序: GetRouter->GetRouterName->GetRouterHandler->GetRouterMiddleware
## prepare

```Swift
// 注册
func prepareRouter() {
    GetRouter.config(nativeScheme: "native", routeNameKey: "ios_router")
    GetRouter.registerHandler(GetRouterCommonHandler())
    GetRouter.registerHandler(GetRouterTestHandler())
}
```
```Swift
// 路由名
extension GetRouterName {
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
                middlewares: [
                    GetRouterMiddlewareVip(priority: 1),
                ],
                action: { params in
                    TestHomePage().push()
                }
        ),
    ]
}
```
## 中间件拦截(权限校验)
```Swift
// 同步
class GetRouterMiddlewareLogin: GetRouterMiddleware {
    
    override func handler(routeName: GetRouterName, params: GetDict?) -> Bool {
        let isLogin = Bool.random()
        if !isLogin {
            print("未登录")
        }
        return isLogin
    }
}

// 异步
class GetRouterMiddlewareVip: GetRouterMiddleware {
    override func handlerAsync(routeName: GetRouterName, params: GetDict?) async throws -> Bool {
        try await withCheckedThrowingContinuation({ continuation in
            DispatchQueue.global().asyncAfter(deadline: .now() + 2, execute: {
                continuation.resume(returning: true)
            })
        })
    }
}
```
## 调用
```Swift
GetRouter.to(name: .home1, params: ["userId": 2222])
GetRouter.to(url: "native://?ios_router=/common/home1&userId=2222")
```

## Author

suyikun, 270081841@qq.com

## License

GetRouter is available under the MIT license. See the LICENSE file for more info.
