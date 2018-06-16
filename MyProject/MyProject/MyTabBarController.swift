//
//  MyTabBarController.swift
//  MyProject
//
//  Created by Sherry on 2018/6/16.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tabbar底部默认的蓝色字体设置为红色
        let tabbar = UITabBar.appearance()
        tabbar.tintColor = UIColor(red: 245 / 255.0, green: 90 / 255.0, blue: 93 / 255.0, alpha: 1.0)
        
        //添加子控制器
        addChildViewController()
    }
    
    //添加子控制器
    func addChildViewController() {
        setChildViewController(HomeViewController(), title: "首页", imageName: "home_tabbar_32x32_", selectedImageName: "home_tabbar_press_32x32_")
        setChildViewController(VideoViewController(), title: "视频", imageName: "video_tabbar_32x32_", selectedImageName: "video_tabbar_press_32x32_")
        setChildViewController(HuoshanViewController(), title: "小视频", imageName: "huoshan_tabbar_32x32_", selectedImageName: "huoshan_tabbar_press_32x32_")
        setChildViewController(MineViewController(), title: "我的", imageName: "mine_tabbar_32x32_", selectedImageName: "mine_tabbar_press_32x32_")
    }
    
    //初始化子控制器
    func setChildViewController(_ childController: UIViewController, title:String, imageName:String, selectedImageName:String) {
        //设置 tabbar 文字和图片
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        //设置导航栏标题
        childController.title = title
        
        //添加导航控制器为 TabBarController 的子控制器
        let navVc = MyNavigationController(rootViewController: childController)
        addChildViewController(navVc)
    }

}
