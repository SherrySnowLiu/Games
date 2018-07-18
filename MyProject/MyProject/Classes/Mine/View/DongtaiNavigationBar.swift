//
//  DongtaiNavigationBar.swift
//  MyProject
//
//  Created by Sherry on 2018/7/18.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit
import IBAnimatable
import Kingfisher

class DongtaiNavigationBar: UIView ,NibLoadable{
    
    var user = DongtaiUser(){
        didSet{
            avatarButton.kf.setImage(with: URL(string: user.avatar_url), for: .normal)
            nameButton.setTitle(user.screen_name, for: .normal)
            followersButton.setTitle(user.followersCount, for: .normal)
        }
    }
    

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatarButton: AnimatableButton!
    @IBOutlet weak var vImageView: UIImageView!
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var followersButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameButton.theme_setTitleColor("colors.black", forState: .normal)
        followersButton.theme_setTitleColor("colors.black", forState: .normal)
    }
    @IBAction func buttonClicked(_ sender: Any) {
    }
    
    ///控件的固有属性大小
    override var intrinsicContentSize: CGSize{
        return UILayoutFittingExpandedSize
    }
}
