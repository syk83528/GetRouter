//
//  TestHomePage.swift
//  GetRouter_Example
//
//  Created by suyikun on 2023/2/26.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation

class TestHomePage: BaseTablePage<ExampleItemModel> {
    override func viewDidLoad() {
        super.viewDidLoad()
        items = [
            ExampleItemModel(name: "撒撒撒说a", T: .test_a),
            ExampleItemModel(name: "撒撒撒说b", T: .test_b),
            ExampleItemModel(name: "撒撒撒说c", T: .test_c),
            ExampleItemModel(name: "撒撒撒说d", T: .test_d),
            ExampleItemModel(name: "撒撒撒说e", T: .test_e),
            ExampleItemModel(name: "撒撒撒说f", T: .test_f),
        ]
    }
    
    override func setupTable() {
        super.setupTable()
        table.register(ExampleItemCell.self, forCellReuseIdentifier: "ExampleItemCell")
        table.reloadData()
    }
    
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
    }
}
 
