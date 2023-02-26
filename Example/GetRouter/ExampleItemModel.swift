//
//  ExampleItemModel.swift
//  GetRouter_Example
//
//  Created by suyikun on 2023/2/26.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import GetRouter

class ExampleItemModel {
    
    var name: String
    
    var T: GetRouterName
    
    init(name: String, T: GetRouterName) {
        self.name = name
        self.T = T
    }
}
