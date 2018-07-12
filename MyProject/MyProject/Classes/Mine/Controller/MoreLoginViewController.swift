//
//  MoreLoginViewController.swift
//  MyProject
//
//  Created by Sherry on 2018/6/26.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit
import IBAnimatable

class MoreLoginViewController: AnimatableModalViewController {

    //关闭界面按钮
    @IBOutlet weak var loginCloseButton: UIButton!
    //顶部文字
    @IBOutlet weak var topLabel: UILabel!
    //手机号 view
    @IBOutlet weak var mobileView: AnimatableView!
    //验证码 view
    @IBOutlet weak var passwordView: AnimatableView!
    //找回密码 view
    @IBOutlet weak var findPasswordView: UIView!
    //发送验证码 view
    @IBOutlet weak var sendVerifyView: UIView!
    //发送验证码按钮
    @IBOutlet weak var sendVerifyButton: UIButton!
    //手机号输入框
    @IBOutlet weak var mobiletextField: UITextField!
    //找回密码按钮
    @IBOutlet weak var findpasswordButton: UIButton!
    //密码输入框
    @IBOutlet weak var passwordtextField: UITextField!
    //未注册
    @IBOutlet weak var middleTipLabel: UILabel!
    //进入头条
    @IBOutlet weak var enterTouTiaoButton: AnimatableButton!
    //阅读按钮
    @IBOutlet weak var readButton: UIButton!
    //阅读条款
    @IBOutlet weak var readLabel: UILabel!
    //账号密码登陆
    @IBOutlet weak var loginModelButton: UIButton!
    //微信登陆按钮
    @IBOutlet weak var wechatLoginButton: UIButton!
    //qq登陆按钮
    @IBOutlet weak var qqLoginButton: UIButton!
    //天翼登陆按钮    
    @IBOutlet weak var tianyiLoginButton: UIButton!
    //邮箱登陆按钮
    @IBOutlet weak var mailLoginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginModelButton.setTitle("免密码登陆", for: .selected)
        
        view.theme_backgroundColor = "colors.cellBackgroundColor"
        topLabel.theme_textColor = "colors.black"
        middleTipLabel.theme_textColor = "colors.cellRightTextColor"
        readLabel.theme_textColor = "colors.black"
        enterTouTiaoButton.theme_backgroundColor = "colors.enterToutiaoBackgroundColor"
        enterTouTiaoButton.theme_setTitleColor("colors.enterToutiaoTextColor", forState: .normal)
        readButton.theme_setImage("images.loginReadButton", forState: .selected)
        readButton.theme_setImage("images.loginReadButtonSelected", forState: .normal)
        mobileView.theme_backgroundColor = "colors.loginMobileViewBackgroundColor"
        passwordView.theme_backgroundColor = "colors.loginMobileViewBackgroundColor"
        loginCloseButton.theme_setImage("images.loginCloseButtonImage", forState: .normal)
        wechatLoginButton.theme_setImage("images.moreLoginWechatButton", forState: .normal)
        qqLoginButton.theme_setImage("images.moreLoginQQButton", forState: .normal)
        tianyiLoginButton.theme_setImage("images.moreLoginTianyiButton", forState: .normal)
        mailLoginButton.theme_setImage("images.moreLoginMailButton", forState: .normal)
    }
    @IBAction func loginModelButtonClicked(_ sender: UIButton) {
        loginModelButton.isSelected = !sender.isSelected
        sendVerifyView.isHidden = sender.isSelected
        findPasswordView.isHidden = !sender.isSelected
        middleTipLabel.isHidden = sender.isSelected
        passwordtextField.placeholder = sender.isSelected ? "密码" : "请输入验证码"
        topLabel.text = sender.isSelected ? "账号密码登陆" : "登陆你的头条，精彩永不消失"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func readButtonClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func moreLoginColseButtonClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
