//
//  UserDetailHeaderView.swift
//  MyProject
//
//  Created by Sherry on 2018/7/4.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit
import IBAnimatable

class UserDetailHeaderView: UIView {
    
    var userDetail:UserDetail?{
        didSet{
            backgroundImageView.kf.setImage(with: URL(string: userDetail!.bg_img_url)!)
            avatarImageView.kf.setImage(with: URL(string: userDetail!.avatar_url)!)
            vImageView.isHidden = !userDetail!.user_verified
            nameLabel.text = userDetail!.screen_name
            if userDetail!.verified_agency == "" {
                verifiedAgnecyLabelHeight.constant = 0
                verifiedAgencyLabelTop.constant = 0
            } else {
                verifiedAgencyLabel.text = userDetail!.verified_agency + "："
                verfifiedContentLabel.text = userDetail!.verified_content
            }
            concernButton.isSelected = userDetail!.is_following
            if userDetail!.area == "" {
                areaButton.isHidden = true
                areaButtonHeight.constant = 0
                areaButtonTop.constant = 0
            } else {
                areaButton.setTitle(userDetail!.area, for: .normal)
            }
            descriptionLabel.text = userDetail!.description as String
            if userDetail!.descriptionHeight! > 21 {
                unfoldButton.isHidden = false
                unfoldButtonWidth.constant = 40.0
            }
            //推荐按钮的约束
            recommendButtonWidth.constant = 0
            recommendButtonTrailing.constant = 10.0
            followersCountLabel.text = userDetail!.followersCount
            followingsCountLabel.text = userDetail!.followingsCount
            layoutIfNeeded()
        }
    }
    //背景图片
    @IBOutlet weak var backgroundImageView: UIImageView!
    //背景图片顶部约束
    @IBOutlet weak var bgImageViewTop: NSLayoutConstraint!
    //用户头像
    @IBOutlet weak var avatarImageView: UIImageView!
    //V 图标
    @IBOutlet weak var vImageView: UIImageView!
    //用户名
    @IBOutlet weak var nameLabel: UILabel!
    //头条号图标
    @IBOutlet weak var toutiaohaoImageView: UIImageView!
    //发私信按钮
    @IBOutlet weak var sendMailButton: UIButton!
    //关注按钮
    @IBOutlet weak var concernButton: AnimatableButton!
    //推荐
    @IBOutlet weak var recommendButton: AnimatableButton!
    @IBOutlet weak var recommendButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var recommendButtonTrailing: NSLayoutConstraint!
    //推荐 view
    @IBOutlet weak var recommendView: UIView!
    @IBOutlet weak var recommendViewHeight: NSLayoutConstraint!
    //头条认证
    @IBOutlet weak var verifiedAgencyLabel: UILabel!
    @IBOutlet weak var verifiedAgnecyLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var verifiedAgencyLabelTop: NSLayoutConstraint!
    //认证内容
    @IBOutlet weak var verfifiedContentLabel: UILabel!
    //地区
    @IBOutlet weak var areaButton: UIButton!
    @IBOutlet weak var areaButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var areaButtonTop: NSLayoutConstraint!
    //描述内容
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionLabelHeight: NSLayoutConstraint!
    //展开按钮
    @IBOutlet weak var unfoldButton: UIButton!
    @IBOutlet weak var unfoldButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var unfoldButtonTrailing: NSLayoutConstraint!
    //关注数量
    @IBOutlet weak var followingsCountLabel: UILabel!
    //粉丝数量
    @IBOutlet weak var followersCountLabel: UILabel!
    //文章、视频、问答
    @IBOutlet weak var topTabView: UIView!
    @IBOutlet weak var topTabHeight: NSLayoutConstraint!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var bottomScrollView: UIScrollView!
    //底层view
    @IBOutlet weak var baseView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    //发私信按钮
    @IBAction func sendMailButtonClicked() {
        
    }
    //关注按钮
    @IBAction func concernButtonClicked(_ sender: AnimatableButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{ //已关注，点击取消关注
            NetworkTool.loadRelationUnfollow(user_id: userDetail!.user_id) { (_) in
                sender.isSelected = !sender.isSelected
                self.recommendButton.isHidden = true
                self.recommendButton.isSelected = false
                self.recommendButtonWidth.constant = 0
                self.recommendButtonTrailing.constant = 0
                self.recommendViewHeight.constant = 0
                UIView.animate(withDuration: 0.25, animations: {
                    self.recommendButton.imageView?.transform = .identity
                    self.layoutIfNeeded()
                }){ (_) in
                    self.resetLayout()
                }
            }
        }else{//未关注，点击则关注该用户
            NetworkTool.loadRelationFollow(user_id: userDetail!.user_id) { (_) in
                sender.isSelected = !sender.isSelected
                self.recommendButton.isHidden = false
                self.recommendButton.isSelected = false
                self.recommendButtonWidth.constant = 28.0
                self.recommendButtonTrailing.constant = 15.0
                self.recommendViewHeight.constant = 223.0
                UIView.animate(withDuration: 0.25, animations: {
                    self.layoutIfNeeded()
                }) { (_) in
                    self.resetLayout()
                    NetworkTool.loadRelationUserRecommend(user_id: self.userDetail!.user_id, completionHandler: { (userCard) in
                        
                    })
                }
            }
        }
    }
    
    //推荐关注按钮
    @IBAction func recommendButtonClicked(_ sender: AnimatableButton) {
        sender.isSelected = !sender.isSelected
        recommendViewHeight.constant = sender.isSelected ? 0 : 223.0
        UIView.animate(withDuration: 0.25, animations: {
            sender.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(sender.isSelected ? Double.pi : 0))
            self.layoutIfNeeded()
        }) { (_) in
            self.resetLayout()
        }
    }
    
    //展开按钮
    @IBAction func unfoldButtonClicked() {
        unfoldButton.isHidden = true
        unfoldButtonWidth.constant = 0
        descriptionLabelHeight.constant = userDetail!.descriptionHeight!
        UIView.animate(withDuration: 0.25, animations: {
            self.layoutIfNeeded()
        }) { (_) in
            self.resetLayout()
        }
    }
    
    class func HeaderView() -> UserDetailHeaderView {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.last as! UserDetailHeaderView
    }
    
    fileprivate func resetLayout(){
        baseView.height = topTabView.frame.maxY
        height = baseView.frame.maxY
    }
    
    
}
