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
        navigationBar.theme_barTintColor = "colors.cellBackgroundColor"
        navigationBar.theme_tintColor = "colors.navigationBarTintColor"
        
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
