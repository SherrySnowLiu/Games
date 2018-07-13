//
//  HomeNaviagtionBar.swift
//  MyProject
//
//  Created by Sherry on 2018/7/12.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit
import IBAnimatable

class HomeNaviagtionBar: UIView,NibLoadable {

    @IBOutlet weak var avatarButton: UIButton!
    @IBOutlet weak var searchButton: AnimatableButton!
    
    var didSelectedAvatarButton:(()->())?
    var didSelectedSearchButton:(()->())?
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        searchButton.setImage(UIImage(named: "search_small_16x16_"), for: [.normal,.highlighted])
        searchButton.theme_backgroundColor = "colors.cellBackgroundColor"
        searchButton.theme_setTitleColor("colors.grayColor150", forState: .normal)
        searchButton.contentHorizontalAlignment = .left
        searchButton.imageEdgeInsets = UIEdgeInsetsMake(0,10,0,0)
        searchButton.titleEdgeInsets = UIEdgeInsetsMake(0,15,0,0)
        searchButton.titleLabel?.lineBreakMode = .byTruncatingTail
        avatarButton.theme_setImage("images.home_no_login_head", forState: .normal)
        avatarButton.theme_setImage("images.home_no_login_head", forState: .highlighted)
        
        NetworkTool.loadHomeSearchSuggestInfo { (suggestInfo) in
            self.searchButton.setTitle(suggestInfo, for: .normal)
        }
    }
    
    ///控件的固有属性大小
    override var intrinsicContentSize: CGSize{
        return UILayoutFittingExpandedSize
    }
    
    ///重写 frame
    override var frame: CGRect{
        didSet{
            super.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 44)
        }
    }
    
    @IBAction func avatarButtonClicked(_ sender: UIButton) {
        didSelectedAvatarButton?()
    }
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        didSelectedSearchButton?()
    }
}
