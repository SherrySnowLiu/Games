//
//  NavigationBarView.swift
//  MyProject
//
//  Created by Sherry on 2018/7/10.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit
import IBAnimatable

class NavigationBarView: UIView,NibLoadable {
    
    var goBackButtonClicked:(()->())?

    var userDetail:UserDetail?{
        didSet{
            nameLabel.text = userDetail!.screen_name
            concernButton.isSelected = userDetail!.is_following
            concernButton.theme_backgroundColor = userDetail!.is_following ? "colors.userDetailFollowingConcernBtnBgColor":"colors.userDetailConcernBtnBgColor"
            concernButton.borderColor = userDetail!.is_following ? .garyColor232() : .globalRedColor()
            concernButton.borderWidth = userDetail!.is_following ? 1 : 0
            
        }
    }
    
    @IBOutlet weak var navigationBar: UIView!
    
    @IBOutlet weak var returnButton: UIButton!
    
    @IBOutlet weak var moreButton: UIButton!
    //关注按钮
    @IBOutlet weak var concernButton: AnimatableButton!
    //标题
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        returnButton.theme_setImage("images.personal_home_back_white_24x24_", forState: .normal)
        moreButton.theme_setImage("images.new_morewhite_titlebar_22x22_", forState: .normal)
        concernButton.setTitle("关注", for: .normal)
        concernButton.setTitle("已关注", for: .selected)
        //设置主题颜色
        concernButton.theme_setTitleColor("colors.userDetailConcernButtonTextColor", forState: .normal)
        concernButton.theme_setTitleColor("colors.userDetailConcernButtonSelectedTextColor", forState: .selected)
        
    }
    
    @IBAction func returnButtonClicked(_ sender: UIButton) {
        goBackButtonClicked?()
    }
    
    @IBAction func moreButtonClicked(_ sender: UIButton) {
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        height = navigationBar.frame.maxY
    }
    
    //关注按钮
    @IBAction func concernButtonClicked(_ sender: AnimatableButton) {
        //        sender.isSelected = !sender.isSelected
        if sender.isSelected{ //已关注，点击取消关注
            NetworkTool.loadRelationUnfollow(user_id: userDetail!.user_id) { (_) in
                sender.isSelected = !sender.isSelected
                
            }
        }else{//未关注，点击则关注该用户
            NetworkTool.loadRelationFollow(user_id: userDetail!.user_id) { (_) in
                sender.isSelected = !sender.isSelected
                
            }
        }
    }
}
