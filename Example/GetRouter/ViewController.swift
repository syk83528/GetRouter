//
//  ViewController.swift
//  GetRouter
//
//  Created by suyikun on 02/26/2023.
//  Copyright (c) 2023 suyikun. All rights reserved.
//

import UIKit
import GetRouter

class ViewController: BaseTablePage<ExampleItemModel> {
    // MARK: - ----------------------------------info
    // MARK: - ----------------------------------system
    override func viewDidLoad() {
        super.viewDidLoad()
        items =
        [
            ExampleItemModel(name: "测试跳转", T: .test),
            ExampleItemModel(name: "测试单拦截器", T: .home1),
            ExampleItemModel(name: "测试多拦截器", T: .home2),
            ExampleItemModel(name: "测试异步拦截器", T: .home3),
            ExampleItemModel(name: "测试同步加异步拦截器", T: .home4),
        ]
    }
    override func setupTable() {
        super.setupTable()
        table.register(ExampleItemCell.self, forCellReuseIdentifier: "ExampleItemCell")
        table.reloadData()
    }
    // MARK: - ----------------------------------action
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExampleItemCell", for: indexPath) as! ExampleItemCell
        cell.update(model: items[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = items[indexPath.row]
        GetRouter.to(name: model.T)
//        GetRouter.to(name: .home1, params: ["userId": 2222])
//        GetRouter.to(url: "native://?ios_router=/common/home1&userId=2222")
    }
    // MARK: - ----------------------------------ui
}

