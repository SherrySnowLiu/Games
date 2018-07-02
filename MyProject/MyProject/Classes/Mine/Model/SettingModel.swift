//
//  SettingModel.swift
//  MyProject
//
//  Created by Sherry on 2018/6/27.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import Foundation
import HandyJSON

struct SettingModel:HandyJSON {
    var title:String = ""
    var subtitle:String = ""
    var rightTitle:String = ""
    var isHiddenRightTitle:Bool = false
    var isHiddenSubtitle:Bool = false
    var isHiddenRightArrow:Bool = false
    var isHiddenSwitch:Bool = false
}
