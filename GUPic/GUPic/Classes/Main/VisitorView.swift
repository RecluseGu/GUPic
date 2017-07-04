//
//  VisitorView.swift
//  GUPic
//
//  Created by Recluse on 2017/6/27.
//  Copyright © 2017年 Recluse. All rights reserved.
//

import UIKit

class VisitorView: UIView {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var descTitleLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    
    func setVisitorViewInfo(iconName: String?, descTitle: String){
        
        descTitleLabel.text = descTitle
        
        guard let name = iconName else{
            return
        }
        iconImageView.image = UIImage(named: name)
        
        
    }
    
    class func visitorView() -> VisitorView {
        return Bundle.main.loadNibNamed("VisitorView", owner: nil, options: nil)!.last as! VisitorView
    }
    
}
