//
//  HomeTableViewController.swift
//  GUPic
//
//  Created by Recluse on 2017/6/26.
//  Copyright © 2017年 Recluse. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController, BannerViewControllerDelegaate{

    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    var bannerView: BannerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !isLogin{
            visitorView?.setVisitorViewInfo(iconName: nil, descTitle: "关注一些人，回这里看看有什么惊喜啊")
            return
        }
        
        setupInitView()
        
    }
    
    func setupInitView() {
        
        setupBannerView()
        
    }
    
    func setupBannerView() {
        bannerView = BannerViewController()
        bannerView.delegate = self
        bannerView.view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight / 4)
        
        self.addChildViewController(bannerView)
        self.view.addSubview(bannerView.view)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.handleTapAction(_:)))
        bannerView.view.addGestureRecognizer(tap)
    }
    
    func handleTapAction(_ tap:UITapGestureRecognizer)->Void{
        //获取图片索引值
        let index = bannerView.currentIndex
        //弹出索引信息
        let alertController = UIAlertController(title: "您点击的图片索引是：", message: "\(index)", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func bannerViewSize() -> CGSize {
        return CGSize(width: screenWidth, height: screenHeight / 4)
    }
    
    func bannerDataSource() -> [String] {
        return ["http://bizhi.zhuoku.com/bizhi2008/0516/3d/3d_desktop_13.jpg",
                "http://tupian.enterdesk.com/2012/1015/zyz/03/5.jpg",
                "http://img.web07.cn/UpImg/Desk/201301/12/desk230393121053551.jpg",
                "http://bizhi.zhuoku.com/wall/jie/20061124/cartoon2/cartoon014.jpg"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
