//
//  MyFirstSectionCell.swift
//  MyProject
//
//  Created by Sherry on 2018/6/20.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit

class MyFirstSectionCell: UITableViewCell {
    //标题
    @IBOutlet weak var leftLabel: UILabel!
    //副标题
    @IBOutlet weak var rightLabel: UILabel!
    //右边箭头
    @IBOutlet weak var rightImageView: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
