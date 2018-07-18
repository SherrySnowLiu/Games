//
//  PostVideoOrArticleView.swift
//  MyProject
//
//  Created by Sherry on 2018/7/11.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit
import Kingfisher

class PostVideoOrArticleView: UIView ,NibLoadable{

    var origin_group = DongtaiOriginGroup(){
        didSet{
            titleLable.text = origin_group.source + " " + origin_group.title
            if origin_group.thumb_url != ""{
                iconButton.kf.setBackgroundImage(with: URL(string: origin_group.thumb_url), for: .normal)
            }
            switch origin_group.media_type {
            case .postArticle:
                iconButton.setImage(nil, for: .normal)
            case .postVideo:
                iconButton.setImage(UIImage(named: "smallvideo_all_32x32_"), for: .normal)
            }
        }
    }
    
    var group = DongtaiOriginGroup(){
        didSet{
            titleLable.text = group.title
            if group.thumb_url != ""{
                iconButton.kf.setBackgroundImage(with: URL(string: group.thumb_url), for: .normal)
            }
            switch group.media_type {
            case .postArticle:
                iconButton.setImage(nil, for: .normal)
            case .postVideo:
                iconButton.setImage(UIImage(named: "smallvideo_all_32x32_"), for: .normal)
            }
        }
    }
    
    @IBOutlet weak var iconButton:UIButton!
    
    @IBOutlet weak var titleLable:UILabel!
    @IBOutlet weak var iconButtonWidth: NSLayoutConstraint!
    
    @IBAction func coverButtonClicked(_ sender:UIButton){
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
        titleLable.theme_textColor = "colors.black"
        titleLable.theme_backgroundColor = "colors.grayColor247"
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        width = screenWidth - 30
    }
}
