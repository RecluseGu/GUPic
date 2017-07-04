//
//  MainViewController.swift
//  GUPic
//
//  Created by Recluse on 2017/6/26.
//  Copyright © 2017年 Recluse. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = UIColor.orange
        addChildViewControllers()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBar.addSubview(composeButton)
        let rect = composeButton.frame
        let width = tabBar.bounds.width / CGFloat(childViewControllers.count)
//        print(tabBar.frame.height) --> 49
        composeButton.frame = CGRect(x: width * 2, y: (tabBar.frame.height - rect.height) / 2, width: width, height: rect.height)
    }
    
    func addChildViewControllers() {
        //addChildViewController(childController: HomeViewController(), title: "首页", imageName: "tabbar_home")
        addHomeViewController(childController: HomeViewController(), title: "首页", imageName: "tabbar_home")
        addChildViewController(childController: DiscoverViewController(), title: "发现", imageName: "tabbar_discover")
        addChildViewController(childController: NullViewController(), title: "", imageName: "")
        addChildViewController(childController: MessageViewController(), title: "消息", imageName: "tabbar_message")
        addChildViewController(childController: MeViewController(), title: "我的", imageName: "tabbar_me")
    }
    
    func addHomeViewController(childController: UIViewController, title: String, imageName: String) {
        childController.tabBarItem.title = title
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        addChildViewController(childController)
        
    }
    
    
    func addChildViewController(childController: UIViewController, title: String, imageName: String) {
        childController.title = title
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        
        let nav = UINavigationController(rootViewController: childController)
        addChildViewController(nav)
    }
    
    @objc private func composeBtnClick(btn:UIButton){
        print(btn)
    }
    
    @objc private lazy var composeButton: UIButton = {
        let btn = UIButton(imageName: "tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
        btn.addTarget(self, action: #selector(composeBtnClick(btn:)), for: UIControlEvents.touchUpInside)
        return btn
        
    }()
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
