//
//  MessageTableViewController.swift
//  GUPic
//
//  Created by Recluse on 2017/6/26.
//  Copyright © 2017年 Recluse. All rights reserved.
//

import UIKit

class MessageViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !isLogin{
            visitorView?.setVisitorViewInfo(iconName: "visitordiscover_image_message", descTitle: "登录后，别人评论你的状态，给你点的赞，都会在这里收到通知哦")
            return
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
