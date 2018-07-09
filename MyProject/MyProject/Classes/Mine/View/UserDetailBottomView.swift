//
//  UserDetailBottomView.swift
//  MyProject
//
//  Created by Sherry on 2018/7/9.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit

class UserDetailBottomView: UIView {
    
    var bottomTabs = [BottomTab](){
        didSet{
            let buttonWidth = (screenWidth - CGFloat(bottomTabs.count)) / CGFloat(bottomTabs.count)
            
            for (index,bottomTab) in bottomTabs.enumerated(){
                //按钮
                let button = UIButton(frame: CGRect(x: CGFloat(index) * (buttonWidth + 1), y: 0, width: buttonWidth, height: height))
                button.setTitle(bottomTab.name, for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                button.theme_setTitleColor("colors.black", forState: .normal)
                button.theme_setImage("images.tabbar-options", forState: .normal)
                button.addTarget(self, action: #selector(bottomTabButtonClicked(button:)), for: .touchUpInside)
                self.addSubview(button)
                //分割线
                if index < bottomTabs.count - 1 {
                    let separatorView = UIView(frame: CGRect(x: button.frame.maxX, y: 6, width: 1, height: 32))
                    separatorView.theme_backgroundColor = "colors.separatorViewColor"
                    addSubview(separatorView)
                }
            }
        }
    }
    
    @objc func bottomTabButtonClicked(button:UIButton) {
        let bottomTab = bottomTabs[button.tag]
        if bottomTab.children.count == 0 { //直接跳转到下一控制器
            
        }else{ //弹出 子视图
            
        }
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
