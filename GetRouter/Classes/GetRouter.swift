//
//  GetRouter.swift
//  spsd
//
//  Created by suyikun on 2022/1/7.
//  Copyright © 2022 未来. All rights reserved.
//

import Foundation

struct GetRouterConfig {
    /// 本地协议头
    var nativeScheme: String = "native"
    /// 本地路由名
    var routeNameKey: String = "ios_path"
}

public typealias GetDict = [String: Any?]

final public class GetRouter {
    // MARK: - --------------------------------------singleton
    private static let to = GetRouter()
    private init() {}
    // MARK: - --------------------------------------info
    private var config: GetRouterConfig = GetRouterConfig()
    /// 路由处理
    private var handler: GetRougerHandler = GetRougerHandler()
    // MARK: - --------------------------------------func
    // MARK: 配置初始信息
    /// native://?ios_path=home&userId=222222
    /// - Parameters:
    ///   - nativeScheme: 本地协议头 例子中是"native"
    ///   - routeNameKey: 本地路由名 例子中是"ios_path"
    public static func config(nativeScheme: String,
                              routeNameKey: String
    ) {
        to.config.nativeScheme = nativeScheme
        to.config.routeNameKey = routeNameKey
    }
    // MARK:  注册路由处理 默认已有一个处理,秩序注册子路由处理即可
    public static func registerHandler(_ source: GetRouterHandlerSource) {
        to.handler.subHandlers.append(source)
    }
    
    // MARK: 本地调用
    public static func to(name: GetRouterName,
                          params: GetDict? = nil,
                          modal: Bool = false) {
        to._doRouter(name: name, params: params)
    }
    // MARK: web调用
    public static func to(url: String?,
                          params: GetDict? = nil,
                          modal: Bool = false) {
        guard var url = url else { return }
        
        url = to._urlEncoding(url)
        
        guard let urlCom = URLComponents(string: url),
              let scheme = urlCom.scheme
        else {
            getRouterllog("无法正常转换: \(url)")
            return
        }
        switch scheme {
        case "http", "https":
            // web处理
            to(name: .web, params: ["url": url])
            break;
        case to.config.nativeScheme:
            // 本地的话,解析提取RouteName, 参数合并
            to._parse(urlCom: urlCom, params: params)
        default:
            getRouterllog("不支持的协议头: \(url)")
        }
    }
    
    private func _urlEncoding(_ url: String) -> String {
        //        CharacterSet.urlHostAllowed: 被转义的字符有  "#%/<>?@\^`{|}
        //        CharacterSet.urlPathAllowed: 被转义的字符有  "#%;<>?[\]^`{|}
        //        CharacterSet.urlUserAllowed: 被转义的字符有   "#%/:<>?@[\]^`
        //        CharacterSet.urlQueryAllowed: 被转义的字符有  "#%<>[\]^`{|}
        //        CharacterSet.urlPasswordAllowed 被转义的字符有 "#%/:<>?@[\]^`{|}
        //        CharacterSet.urlFragmentAllowed 被转义的字符有 "#%<>[\]^`{|}
        //        let characterSet = CharacterSet(charactersIn: "#").inverted
        getRouterllog(url)
        let characterSet = CharacterSet.urlQueryAllowed
        let encodingUrl = url.addingPercentEncoding(withAllowedCharacters: characterSet) ?? url
        getRouterllog(encodingUrl)
        return encodingUrl
    }
    
    /// 路由解析, 将远程参数整合到一个 Map 中
    /// - Parameters:
    ///   - name: 全路由
    ///   - argument: 参数
    private func _parse(urlCom: URLComponents, params: GetDict?) {
        guard let queryItems = urlCom.queryItems,
              let item = queryItems.first(where: {
                  $0.name == config.routeNameKey
              })
        else {
            return
        }
        // 提取本地路由名
        let routeName = GetRouterName(rawValue: item.value ?? "")
        
        // 拼接参数,合并参数
        var dict = params ?? GetDict()
        if let queryItems = urlCom.queryItems {
            for queryItem in queryItems {
                if let value = queryItem.value {
                    getRouterllog("key: \(queryItem.name), value: \(value)")
                    dict[queryItem.name] = value
                }
            }
        }
        /// 执行路由
        _doRouter(name: routeName, params: dict)
    }
    
    /// 执行路由
    private func _doRouter(name: GetRouterName, params: GetDict?) {
        handler.handler(name: name, params: params)
    }
}


public func getRouterllog(_ paramter: Any, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
//#if DEBUG
    // 创建一个日期格式器
    let formatter = DateFormatter()
    // 为日期格式器设置格式字符串
    formatter.dateFormat = "HH:mm:ss"
    // 使用日期格式器格式化当前日期、时间
    let datestr = formatter.string(from: Date())

    let fileName = (file as NSString).lastPathComponent

    print("Router: [\(datestr)]-[\(fileName)][第\(lineNum)行] \n\(paramter)")
//#endif
}
