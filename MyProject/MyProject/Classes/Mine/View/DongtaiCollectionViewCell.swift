//
//  DongtaiCollectionViewCell.swift
//  MyProject
//
//  Created by Sherry on 2018/7/11.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit
import Kingfisher
import SVProgressHUD

class DongtaiCollectionViewCell: UICollectionViewCell,RegisterCellFromNib {
    var isPostSmallVideo = false {
        didSet{
            iconButton.theme_setImage(isPostSmallVideo ? "images.smallvideo_all_32x32_" : nil, forState: .normal)
        }
    }
    var thumbImage:ThumbImage?{
    
        didSet{
            thumbImageView.kf.setImage(with: URL(string: thumbImage!.url as String))
        }
    }
    
    var largeImage = LargeImage(){
        didSet{
            thumbImageView.kf.setImage(with: URL(string: largeImage.url as String), placeholder: nil, options: nil, progressBlock: { (receivedSize, totalSize) in
                let progress = Float(receivedSize) / Float(totalSize)
                SVProgressHUD.showProgress(progress)
                SVProgressHUD.setBorderColor(.clear)
                SVProgressHUD.setForegroundColor(.white)
                
            }) { (image, error, cacheType, imageURL) in
                SVProgressHUD.dismiss()
            }
        }
    }
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var iconButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
