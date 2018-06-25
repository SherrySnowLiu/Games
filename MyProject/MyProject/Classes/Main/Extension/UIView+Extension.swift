//
//  UIView+Extension.swift
//  MyProject
//
//  Created by Sherry on 2018/6/24.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit

protocol RegisterCellOrNib {}

extension RegisterCellOrNib{
    static var identifier:String{
        return "\(self)"
    }
    
    static var nib:UINib?{
        return UINib(nibName: "\(self)", bundle: nil)
    }
}
