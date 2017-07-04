//
//  DiscoverTableViewController.swift
//  GUPic
//
//  Created by Recluse on 2017/6/26.
//  Copyright © 2017年 Recluse. All rights reserved.
//

import UIKit

class DiscoverViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !isLogin{
            visitorView?.setVisitorViewInfo(iconName: "visitordiscover_image_message", descTitle: "登录后，最新最热状态尽在掌握，不再会与美食、美景等潮流擦肩而过哦")
            return
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
