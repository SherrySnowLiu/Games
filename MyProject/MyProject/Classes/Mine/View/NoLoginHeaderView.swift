//
//  NoLoginHeaderView.swift
//  MyProject
//
//  Created by Sherry on 2018/6/25.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit
import IBAnimatable
import SwiftTheme

class NoLoginHeaderView: UIView {

    //收藏、历史、夜间的背景view
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var stackView: UIStackView!
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

    override func awakeFromNib() {
        super.awakeFromNib()
        
        dayOrNightButton.isSelected = UserDefaults.standard.bool(forKey: isNight)
        
        let effectX = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        effectX.maximumRelativeValue = 20
        effectX.minimumRelativeValue = -20
        stackView.addMotionEffect(effectX)
        //设置主题
        mobileButton.theme_setImage("images.loginMobileButton", forState: .normal)
        wechatButton.theme_setImage("images.loginWechatButton", forState: .normal)
        qqButton.theme_setImage("images.loginQQButton", forState: .normal)
        sinaButton.theme_setImage("images.loginSinaButton", forState: .normal)
        favoriteButton.theme_setImage("images.myFavoriteButton", forState: .normal)
        historyButton.theme_setImage("images.myHistoryButton", forState: .normal)
        dayOrNightButton.theme_setImage("images.dayOrNightButton", forState: .normal)
        dayOrNightButton.setTitle("夜间", for: .normal)
        dayOrNightButton.setTitle("日间", for: .selected)
        
        moreloginButton.theme_backgroundColor = "colors.moreLoginBackgroundColor"
        moreloginButton.theme_setTitleColor("colors.moreLoginTextColor", forState: .normal)
        favoriteButton.theme_setTitleColor("colors.black", forState: .normal)
        historyButton.theme_setTitleColor("colors.black", forState: .normal)
        dayOrNightButton.theme_setTitleColor("colors.black", forState: .normal)
        bottomView.theme_backgroundColor = "colors.cellBackgroundColor"
    }
    @IBAction func dayOrNightButtonClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        UserDefaults.standard.set(sender.isSelected, forKey: isNight)
        MyTheme.switchNight(sender.isSelected)
        //通过监听提示tablebar主题已变化
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dayOrNightButtonClicked"), object: sender.isSelected)
    }
    
}
