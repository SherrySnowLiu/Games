//
//  HomeViewController.swift
//  MyProject
//
//  Created by Sherry on 2018/6/16.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    //标题数据表
    fileprivate let newsTitleTable = NewTitleTable()
    
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


extension HomeViewController{
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
//        首页顶部新闻标题的数据
        NetworkTool.loadHomeNewsTitle { (titles) in
            //向数据库中插入数据
            self.newsTitleTable.insert(titles)
        }
    }
}
