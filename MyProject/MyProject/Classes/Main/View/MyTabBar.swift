//
//  MyTabBar.swift
//  MyProject
//
//  Created by Sherry on 2018/6/16.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit

class MyTabBar: UITabBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        theme_backgroundColor = "colors.tabbarTintColor"
        theme_barTintColor = "colors.cellBackgroundColor"
        addSubview(publicButton)
    }
    //懒加载
    //private，绝对私有，除了在当前类中可以访问之外，其他任何类或该类的拓展都不能访问到
    //fileprivate，文件私有，可以在当前类文件中访问，其他文件不能访问
    //open，在任何类文件中都能访问
    //internal，默认，也可以不写
    private lazy var publicButton: UIButton = {
        let publicButton = UIButton(type: .custom)
        publicButton.theme_setBackgroundImage("images.publicButtonBackgroundImage", forState: .normal)
        publicButton.theme_setBackgroundImage("images.publicButtonBackgroundSelectedImage", forState: .selected)
        publicButton.sizeToFit()
        return publicButton
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //当前 tabBar 的宽和高
        let width = frame.width
        let height:CGFloat = 49
        
        publicButton.center =  CGPoint(x: width*0.5, y: height*0.5 - 7)
        //设置其他按钮的 frame
        let buttonW : CGFloat = width*0.2
        let buttonH : CGFloat = height
        let buttonY : CGFloat = 0
        
        var index = 0

        for button in subviews {
            if !button.isKind(of: NSClassFromString("UITabBarButton")!){ continue }
            let buttonX = buttonW * (index > 1 ? CGFloat(index + 1) : CGFloat(index))
            button.frame = CGRect(x: buttonX, y: buttonY, width: buttonW, height: buttonH)
            index += 1
        }
    }

}
