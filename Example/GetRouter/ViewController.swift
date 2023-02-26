//
//  ViewController.swift
//  GetRouter
//
//  Created by suyikun on 02/26/2023.
//  Copyright (c) 2023 suyikun. All rights reserved.
//

import UIKit
import GetRouter

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    // MARK: - ----------------------------------info
    var items: [ExampleItemModel] =
    [
//        ExampleItemModel(name: "GPUImage", T: GPUImageTestPage.self),
        ExampleItemModel(name: "盒子模型", T: .tabSelect),
//        ExampleItemModel(name: "流水布局", T: FirstBigViewController.self),
//        ExampleItemModel(name: "导航转场动画", T: NavAnimateController.self),
//        ExampleItemModel(name: "视频捕获", T:  CaptureVideoPage.self),
//        ExampleItemModel(name: "音视频大小窗", T:  CallCameraSwitchController.self),
//        ExampleItemModel(name: "TAG标签界面", T: TagModelViewController.self),
//        ExampleItemModel(name: "测试", T: TestViewController.self),
//        ExampleItemModel(name: "TextureDemo测试", T: TestTextureViewController.self),
//        ExampleItemModel(name: "裸眼3D", T: CoreMotionViewController.self),
        
    ]
    // MARK: - ----------------------------------system
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(table)
        table.dataSource = self
        table.delegate = self
        table.register(ExampleItemCell.self, forCellReuseIdentifier: "aaaa")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    // MARK: - ----------------------------------action
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "aaaa", for: indexPath) as! ExampleItemCell
        cell.update(model: items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = items[indexPath.row]
        GetRouter.to(name: model.name)
    }
    // MARK: - ----------------------------------ui
    private let table = UITableView()
}

