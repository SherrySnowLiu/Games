//
//  UserDetailWendaCell.swift
//  MyProject
//
//  Created by Sherry on 2018/7/17.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit

class UserDetailWendaCell: UITableViewCell,RegisterCellFromNib {

    var wenda = UserDetailWenda(){
        didSet{
            questionTitleLabel.text = wenda.question.title
            contentLabel.text = wenda.answer.content_abstract.text
            diggCountLabel.text = wenda.answer.diggCount + "赞 "
            readCountLabel.text = wenda.answer.browCount + "人阅读"
            showTimeLabel.text = wenda.answer.show_time
            contentLabelHeight.constant = wenda.answer.content_abstract.textHeight
            layoutIfNeeded()
        }
    }
    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var diggCountLabel: UILabel!
    @IBOutlet weak var readCountLabel: UILabel!
    @IBOutlet weak var showTimeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
