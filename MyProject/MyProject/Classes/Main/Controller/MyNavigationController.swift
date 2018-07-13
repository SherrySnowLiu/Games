//
//  MyNavigationController.swift
//  MyProject
//
//  Created by Sherry on 2018/6/16.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit

class MyNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //获取全局
        let navigationBar = UINavigationBar.appearance()
//        navigationBar.theme_barTintColor = "colors.cellBackgroundColor"
        navigationBar.theme_tintColor = "colors.black"
        
        if UserDefaults.standard.bool(forKey: isNight) {
            navigationBar.setBackgroundImage(UIImage(named: "navigation_background_night"), for: .default)
        }else{
            navigationBar.setBackgroundImage(UIImage(named: "navigation_background"), for: .default)
        }
        //全局拖拽手势
        initGlobalPan()
        //注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(reciveDayOrNightButtonClicked(notification:)), name: NSNotification.Name(rawValue: "dayOrNightButtonClicked"), object: nil)
    }
    
    //接收按钮点击的通知
    @objc func reciveDayOrNightButtonClicked(notification:Notification){
        let selected = notification.object as! Bool
        if selected {//true，设置为夜间
            navigationBar.setBackgroundImage(UIImage(named: "navigation_background_night"), for: .default)
        }else{
            navigationBar.setBackgroundImage(UIImage(named: "navigation_background"), for: .default)
        }
    }
    
    //拦截push操作
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(named: "lefterbackicon_titlebar_24x24_"), style: .plain, target: self, action: #selector(navigationBack))
        }
        super.pushViewController(viewController, animated: true)
    }
    
    //返回上一控制器
    @objc private func navigationBack(){
        popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

extension MyNavigationController:UIGestureRecognizerDelegate{
    //全局拖拽手势
    func initGlobalPan(){
        let target = interactivePopGestureRecognizer?.delegate
        let globalPan = UIPanGestureRecognizer(target: target, action: Selector(("handleNavigationTransition:")))
        globalPan.delegate = self
        view.addGestureRecognizer(globalPan)
        //禁止系统的手势
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count != 1
    }
}
