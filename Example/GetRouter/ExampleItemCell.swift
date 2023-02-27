//
//  ExampleItemCell.swift
//  GetRouter_Example
//
//  Created by suyikun on 2023/2/26.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class ExampleItemCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func commonInit() {
        textLabel?.textColor = .black
        contentView.backgroundColor = UIColor.orange
    }
    func update(model: ExampleItemModel?) {
        guard let m = model else { return }
        textLabel?.text = m.name
        setNeedsLayout()
    }
}
