//
//  MeTableViewController.swift
//  GUPic
//
//  Created by Recluse on 2017/6/26.
//  Copyright © 2017年 Recluse. All rights reserved.
//

import UIKit

class MeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !isLogin{
            visitorView?.setVisitorViewInfo(iconName: "visitordiscover_image_profile", descTitle: "登录后，你的相册、个人资料会显示在这里展示出来哦")
            return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
