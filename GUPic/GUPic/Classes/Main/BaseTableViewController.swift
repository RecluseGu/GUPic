//
//  BaseViewController.swift
//  GUPic
//
//  Created by Recluse on 2017/7/4.
//  Copyright © 2017年 Recluse. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    var isLogin = true
    var visitorView: VisitorView?
    
    override func loadView() {
        
        isLogin ? super.loadView() : setVisitorView()
    }
    
    private func setVisitorView()
    {
        visitorView = VisitorView.visitorView()
        visitorView?.backgroundColor = UIColor(white: 232.0/255.0, alpha: 1)
        view = visitorView
        
        visitorView?.loginButton.addTarget(self, action: #selector(loginBtnClick(btn:)), for: UIControlEvents.touchUpInside)
        visitorView?.registerButton.addTarget(self, action: #selector(registerBtnClick(btn:)), for: UIControlEvents.touchUpInside)
        
    }
    
    func loginBtnClick(btn: UIButton){
        print("login click")
    }
    
    func registerBtnClick(btn: UIButton){
        print("register click")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
