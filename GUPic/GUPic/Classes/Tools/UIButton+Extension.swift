//
//  UIButton+Extension.swift
//  GUPic
//
//  Created by Recluse on 2017/6/26.
//  Copyright © 2017年 Recluse. All rights reserved.
//

import UIKit

extension UIButton{
    
    convenience init(imageName: String, backgroundImageName: String){
        self.init()
        
        setImage(UIImage(named: imageName), for: UIControlState.normal)
        setImage(UIImage(named: imageName + "highlighted"), for: UIControlState.highlighted)
        
        setBackgroundImage(UIImage(named: backgroundImageName), for: UIControlState.normal)
        setBackgroundImage(UIImage(named: backgroundImageName + "highlighted"), for: UIControlState.highlighted)
        
        sizeToFit()
        
    }
    
}
