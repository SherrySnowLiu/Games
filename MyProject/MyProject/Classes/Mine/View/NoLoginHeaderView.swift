//
//  NoLoginHeaderView.swift
//  MyProject
//
//  Created by Sherry on 2018/6/25.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit
import IBAnimatable

class NoLoginHeaderView: UIView {

    @IBOutlet weak var dayOrNightButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var moreloginButton: AnimatableButton!
    @IBOutlet weak var sinaButton: UIButton!
    @IBOutlet weak var qqButton: UIButton!
    @IBOutlet weak var wechatButton: UIButton!
    @IBOutlet weak var mobileButton: UIButton!
    //背景图片
    @IBOutlet weak var bgImageView: UIImageView!
    class func headerView() -> NoLoginHeaderView {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.last as! NoLoginHeaderView
    }

}
