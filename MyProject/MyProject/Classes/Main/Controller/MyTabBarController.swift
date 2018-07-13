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
        
        //注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(reciveDayOrNightButtonClicked(notification:)), name: NSNotification.Name(rawValue: "dayOrNightButtonClicked"), object: nil)
    }
    //接收按钮点击的通知
    @objc func reciveDayOrNightButtonClicked(notification:Notification){
        let selected = notification.object as! Bool
        if selected {//true，设置为夜间
            for childController in childViewControllers{
                switch childController.title!{
                case "首页":
                    setNightChildController(controller: childController, imageName: "home")
                case "视频":
                    setNightChildController(controller: childController, imageName: "video")
                case "小视频":
                    setNightChildController(controller: childController, imageName: "huoshan")
                case "微头条":
                    setNightChildController(controller: childController, imageName: "weitoutiao")
                default:
                    break
                }
            }
        }else{
            for childController in childViewControllers{
                switch childController.title!{
                case "首页":
                    setDayChildController(controller: childController, imageName: "home")
                case "视频":
                    setDayChildController(controller: childController, imageName: "video")
                case "小视频":
                    setDayChildController(controller: childController, imageName: "huoshan")
                case "微头条":
                    setDayChildController(controller: childController, imageName: "weitoutiao")
                default:
                    break
                }
            }
        }
    }
    
    ///设置夜间控制器
    private func setNightChildController(controller:UIViewController,imageName:String){
        controller.tabBarItem.image = UIImage(named: imageName+"_tabbar_night_32x32_")
        controller.tabBarItem.selectedImage = UIImage(named: imageName+"_tabbar_press_night_32x32_")
    }
    ///设置日间控制器
    private func setDayChildController(controller:UIViewController,imageName:String){
        controller.tabBarItem.image = UIImage(named: imageName+"_tabbar_32x32_")
        controller.tabBarItem.selectedImage = UIImage(named: imageName+"_tabbar_press_32x32_")
    }
    ///添加子控制器
    func addChildViewController() {
        setChildViewController(HomeViewController(), title: "首页", imageName: "home")
        setChildViewController(VideoViewController(), title: "视频", imageName: "video")
        setChildViewController(WeitoutiaoViewController(), title: "微头条", imageName: "weitoutiao")
        setChildViewController(HuoshanViewController(), title: "小视频", imageName: "huoshan")
        //tabar是readonly属性，不能直接修改，利用KVC把readonly属性的权限改过来
        setValue(MyTabBar(), forKey: "tabBar")
    }
    
    ///初始化子控制器
    func setChildViewController(_ childController: UIViewController, title:String, imageName:String) {
        //设置 tabbar 文字和图片
        if UserDefaults.standard.bool(forKey: isNight) {
            setNightChildController(controller: childController, imageName: imageName)
        }else{
            setDayChildController(controller: childController, imageName: imageName)
        }
        //设置导航栏标题
        childController.title = title
        
        //添加导航控制器为 TabBarController 的子控制器
        let navVc = MyNavigationController(rootViewController: childController)
        addChildViewController(navVc)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
