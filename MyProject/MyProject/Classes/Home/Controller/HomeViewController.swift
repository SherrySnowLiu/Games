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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        NetworkTool.loadHomeNewsTitle { (titles) in
            //向数据库中插入数据
            self.newsTitleTable.insert(titles)
        }
    }

}
