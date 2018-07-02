//
//  OfflineDownloadCell.swift
//  MyProject
//
//  Created by Sherry on 2018/7/2.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit

class OfflineDownloadCell: UITableViewCell,RegisterCellOrNib {
    //标题
    @IBOutlet weak var titleLabel: UILabel!
    //勾选图片
    @IBOutlet weak var rightImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
