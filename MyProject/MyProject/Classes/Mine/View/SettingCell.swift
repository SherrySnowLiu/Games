//
//  SettingCell.swift
//  MyProject
//
//  Created by Sherry on 2018/6/27.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell,RegisterCellFromNib {
    //标题
    @IBOutlet weak var titleLabel: UILabel!
    //副标题
    @IBOutlet weak var subtitleLabel: UILabel!
    //右边标题
    @IBOutlet weak var rightTitleLabel: UILabel!
    //右边图片
    @IBOutlet weak var arrowImageView: UIImageView!
    //Switch
    @IBOutlet weak var switchView: UISwitch!
    //分割线
    @IBOutlet weak var bottomline: UIView!
    //副标题的高度
    @IBOutlet weak var subtitleLabelHeight: NSLayoutConstraint!
    
    var setting:SettingModel?{
        didSet{
            titleLabel.text = setting!.title
            subtitleLabel.text = setting!.subtitle
            rightTitleLabel.text = setting!.rightTitle
            arrowImageView.isHidden = setting!.isHiddenRightArrow
            switchView.isHidden = setting!.isHiddenSwitch
            if !setting!.isHiddenSubtitle {
                subtitleLabelHeight.constant = 20
                layoutIfNeeded()
            }
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        theme_backgroundColor = "colors.cellBackgroundColor"
        bottomline.theme_backgroundColor = "colors.separatorViewColor"
        titleLabel.theme_textColor = "colors.black"
        subtitleLabel.theme_textColor = "colors.black"
        rightTitleLabel.theme_textColor = "colors.cellRightTextColor"
        arrowImageView.theme_image = "images.cellRightArrow"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
