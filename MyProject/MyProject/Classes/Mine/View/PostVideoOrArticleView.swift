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

    var group: DongtaiOriginGroup?{
        didSet{
            titleLable.text = group!.title
            iconButton.kf.setBackgroundImage(with: URL(string: group!.image_url), for: .normal)
            switch group!.media_type {
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
