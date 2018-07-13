//
//  VideoViewController.swift
//  MyProject
//
//  Created by Sherry on 2018/6/16.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    lazy var navigationBar:HomeNaviagtionBar = {
        let navigationBar = HomeNaviagtionBar.loadViewFromNib()
        return navigationBar
    }()

}
extension VideoViewController{
    ///设置ui
    private func setupUI(){
        view.theme_backgroundColor = "colors.cellBackgroundColor"
        //设置导航栏样式
        navigationController?.navigationBar.barStyle = .black
        //设置自定义导航栏
        navigationItem.titleView = navigationBar
        ///点击了头像按钮
        navigationBar.didSelectedAvatarButton = { [weak self] in
            self!.navigationController?.pushViewController(MineViewController(), animated: true)
        }
    }
}
