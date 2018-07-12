//
//  DongtaiOriginThreadView.swift
//  MyProject
//
//  Created by Sherry on 2018/7/12.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit

class DongtaiOriginThreadView: UIView ,NibLoadable{
    
    var originthread:DongtaiOriginThread?{
        didSet{
            contentLabel.text = originthread!.content
            contentLabelHeight.constant = originthread!.contentH
            collectionView.thumbImageList = originthread!.thumb_image_list
            layoutIfNeeded()
        }
    }
    
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionView: DongtaiCollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        theme_backgroundColor = "colors.grayColor230"
        contentLabel.theme_textColor = "colors.black"
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        height = originthread!.height
    }
}
