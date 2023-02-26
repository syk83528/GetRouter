//
//  GetRouterMiddlewareVip.swift
//  GetRouter_Example
//
//  Created by suyikun on 2023/2/26.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import GetRouter

class GetRouterMiddlewareVip: GetRouterMiddleware {
    override func handlerAsync(routeName: GetRouterName, params: GetDict?) async throws -> Bool {
        try await withCheckedThrowingContinuation({ continuation in
            DispatchQueue.global().asyncAfter(deadline: .now() + 2, execute: {
                continuation.resume(returning: true)
            })
        })
    }
}
