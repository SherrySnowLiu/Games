//
//  UIColor+Extension.swift
//  MyProject
//
//  Created by Sherry on 2018/6/16.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init(r:CGFloat,g:CGFloat,b:CGFloat,alpha:CGFloat = 1.0){
//        self.init(red:CGFloat,green:CGFloat,blue:CGFloat,alpha:CGFloat)
        self.init(displayP3Red : r / 255.0,green:g / 255.0,blue: b / 255.0,alpha:alpha)
    }
    //背景灰色f8f9f7
    class func globalBackgroundColor() -> UIColor{
        return UIColor(r: 248, g: 249, b: 247)
    }
    
    //背景红色
    class func globalRedColor() -> UIColor{
        return UIColor(r: 230, g: 100, b: 95)
    }
    
    //背景灰色132
    class func grayColor132() -> UIColor{
        return UIColor(r: 132, g: 132, b: 132)
    }
    
    //背景灰色232
    class func garyColor232() -> UIColor{
        return UIColor(r: 232, g: 232, b: 232)
    }
}
