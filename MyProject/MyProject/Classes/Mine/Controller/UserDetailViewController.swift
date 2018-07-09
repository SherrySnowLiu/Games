//
//  UserDetailViewController.swift
//  MyProject
//
//  Created by Sherry on 2018/7/4.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomViewBottom: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var userId:Int = 53271122458
    var userDetail:UserDetail?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        scrollView.addSubview(headerView)
        scrollView.contentSize = CGSize(width: screenWidth, height: 1000)
        //设置约束，避免bottomView顶到边界
        bottomViewBottom.constant = isIPhoneX ? 34 : 0
        view.layoutIfNeeded()
        
        NetworkTool.loadUserDetail(user_id: userId) { (userDetail) in
            self.userDetail = userDetail
            self.headerView.userDetail = userDetail
            if userDetail.bottom_tab.count == 0{
                self.bottomViewBottom.constant = 0
                self.view.layoutIfNeeded()
            }else{
                //赋值给bottomview
                self.bottomView.addSubview(self.mybottomView)
                self.mybottomView.bottomTabs = userDetail.bottom_tab
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    //懒加载
    fileprivate lazy var headerView : UserDetailHeaderView = {
        let headerView = UserDetailHeaderView.loadViewFromNib()
        return headerView
    }()
    
    //懒加载
    fileprivate lazy var mybottomView : UserDetailBottomView = {
        let mybottomView = UserDetailBottomView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        return mybottomView
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
