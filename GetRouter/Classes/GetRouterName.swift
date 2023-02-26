//
//  GetRouterName.swift
//  quick
//
//  Created by suyikun on 2023/2/25.
//

import Foundation
/// 路由列表
public struct GetRouterName: RawRepresentable,
                             ExpressibleByStringLiteral,
                             Hashable,
                             Equatable {
    
    public var rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
    
    public var hashValue: Int {
        rawValue.hashValue
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
    
    /// web的路由名
    public static var web: GetRouterName = "/web"
}


