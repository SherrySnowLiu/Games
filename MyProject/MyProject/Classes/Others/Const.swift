//
//  Const.swift
//  MyProject
//
//  Created by Sherry on 2018/6/16.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit
//屏幕的宽和高
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

//服务器地址
let BASE_URL = "https://is.snssdk.com"

let device_id:String = "6096495334"
let iid:String = "5034850950"

let kMyHeaderViewHeight:CGFloat = 280
let kUserDetailHeaderBGImageViewHeight:CGFloat = 146
let isNight = "isNight"

let isIPhoneX:Bool = screenHeight == 812 ? true : false

///关注的用户详情界面 topTab 的按钮的宽度
let topTabButtonWidth:CGFloat = screenWidth * 0.2
///关注的用户详情界面 topTab 的展示条的宽度和高度
let topTabindicatorWidth:CGFloat = 40
let topTabindicatorHeight:CGFloat = 2

let MyPresentationControllerDismiss = "MyPresentationControllerDismiss"

