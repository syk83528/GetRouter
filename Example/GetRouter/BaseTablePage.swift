//
//  BaseTablePage.swift
//  GetRouter_Example
//
//  Created by suyikun on 2023/2/26.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class BaseTablePage<T>: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - ----------------------------------info
    var items: [T] = []
    // MARK: - ----------------------------------system
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTable()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    
    func setupTable() {
        view.addSubview(table)
        table.dataSource = self
        table.delegate = self
//        table.register(ExampleItemCell.self, forCellReuseIdentifier: "aaaa")
    }
    // MARK: - ----------------------------------action
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("子类实现")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        fatalError("子类实现")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    deinit {
        print("💀💀💀------------ \(Self.self)")
    }
    // MARK: - ----------------------------------ui
    let table = UITableView(frame: .zero, style: .plain)
}

