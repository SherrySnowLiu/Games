//
//  DongtaiCollectionViewCell.swift
//  MyProject
//
//  Created by Sherry on 2018/7/11.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit
import Kingfisher

class DongtaiCollectionViewCell: UICollectionViewCell,RegisterCellFromNib {

//    var thumbImage:DongtaiThumbImageList?{
    var thumbImage:ThumbImage?{
    
        didSet{
            thumbImageView.kf.setImage(with: URL(string: thumbImage!.url as String))
        }
    }
    
    @IBOutlet weak var thumbImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
