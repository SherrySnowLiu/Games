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
    
    var changeStatuBarStyle:UIStatusBarStyle = .lightContent{
        didSet{
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 点击了用户或者话题
        didSelectTopicOrUser()

        view.theme_backgroundColor = "colors.cellBackgroundColor"
        bottomView.theme_backgroundColor = "colors.cellBackgroundColor"
//        view.backgroundColor = UIColor.white
        //设置约束，避免bottomView顶到边界
        bottomViewBottom.constant = isIPhoneX ? 34 : 0
        view.layoutIfNeeded()
        scrollView.delegate = self
        
        view.addSubview(navigationBar)
        navigationBar.goBackButtonClicked={[weak self] in
            self!.navigationController?.popViewController(animated: true)
        }
        
//        userId = 8
        NetworkTool.loadUserDetail(user_id: userId) { (userDetail) in
            //获取用户详情的动态列表数据
            NetworkTool.loadUserDetailDongtaiList(user_id: self.userId,maxCursor:0, completionHandler: { (cursor,dongtais) in
                self.scrollView.addSubview(self.headerView)
                self.userDetail = userDetail
                self.headerView.userDetail = userDetail
                self.navigationBar.userDetail = userDetail
                self.headerView.dongtais = dongtais
                self.headerView.currentTopTabType = .dongtai
                self.headerView.maxCursor = cursor
                if userDetail.bottom_tab.count == 0{
                    self.headerView.height = 969 - 44
                    self.bottomViewBottom.constant = 0
                    self.bottomViewHeight.constant = 0
                    self.view.layoutIfNeeded()
                }else{
                    //赋值给bottomview
                    self.headerView.height = 969
                    self.bottomView.addSubview(self.mybottomView)
                    self.mybottomView.bottomTabs = userDetail.bottom_tab
                }
                self.scrollView.contentSize = CGSize(width: screenWidth, height: self.headerView.height)
            })
            
        }
        headerView.didSelectUserUID = {[weak self] (uid) in
//            print(uid)
            let userDetailVC = UserDetailViewController()
            userDetailVC.userId = uid
            self!.navigationController?.pushViewController(userDetailVC, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    //改变状态栏的字体颜色
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return changeStatuBarStyle
    }
    
    //懒加载 头部
    fileprivate lazy var headerView : UserDetailHeaderView = {
        let headerView = UserDetailHeaderView.loadViewFromNib()
        return headerView
    }()
    
    //懒加载 底部
    fileprivate lazy var mybottomView : UserDetailBottomView = {
        let mybottomView = UserDetailBottomView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        mybottomView.delegate = self
        return mybottomView
    }()
    
    //懒加载 导航栏
    fileprivate lazy var navigationBar : NavigationBarView = {
        let navigationBar = NavigationBarView.loadViewFromNib()
        return navigationBar
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension UserDetailViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        //图片黏住顶部，拉伸
        if offsetY < -44 { //下拉
            //abs()取绝对值
            let totalOffset = kUserDetailHeaderBGImageViewHeight + abs(offsetY)
//            let f = totalOffset / kUserDetailHeaderBGImageViewHeight
//            headerView.backgroundImageView.frame = CGRect(x: -screenWidth * (f - 1) * 0.5, y: offsetY, width: screenWidth, height: totalOffset)
            headerView.backgroundImageView.frame = CGRect(x: 0, y: offsetY, width: screenWidth, height: totalOffset)
            navigationBar.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
        }else if offsetY == 0 {
            for subview in headerView.bottomScrollView.subviews {
                let tableview = subview as! UITableView
                tableview.isScrollEnabled = false
            }
        }else{
            let alpha:CGFloat = (offsetY + 44) / 58
            navigationBar.backgroundColor = UIColor(white: 1.0, alpha: alpha)
            if alpha == 1.0 {
                changeStatuBarStyle = .default
                navigationBar.returnButton.theme_setImage("images.personal_home_back_black_24x24_", forState: .normal)
                navigationBar.moreButton.theme_setImage("images.new_more_titlebar_24x24_", forState: .normal)
            }else{
                changeStatuBarStyle = .lightContent
                navigationBar.returnButton.theme_setImage("images.personal_home_back_white_24x24_", forState: .normal)
                navigationBar.moreButton.theme_setImage("images.new_morewhite_titlebar_22x22_", forState: .normal)
            }
            
            // 14 + 15 + 14   当offsetY为0时，距离顶部 14 + 关注按钮距离上边距 15 + 关注按钮高度的一半 14
            var alpha1:CGFloat = offsetY / 57
            if offsetY > 43 {
                alpha1 = min(alpha1, 1.0)
                navigationBar.nameLabel.isHidden = false
                navigationBar.concernButton.isHidden = false
                navigationBar.nameLabel.textColor = UIColor(r: 0, g: 0, b: 0, alpha: alpha1)
                navigationBar.concernButton.alpha = alpha1
            }else{
                alpha1 = min(0.0, alpha)
                navigationBar.nameLabel.textColor = UIColor(r: 0, g: 0, b: 0, alpha: alpha1)
                navigationBar.concernButton.alpha = alpha1
            }
            //设置 headerView 的 topTab 黏住顶部
            //14 + headerView.topTabView.frame.minY = 215
            if offsetY >= (14 + headerView.topTabView.frame.minY){
                headerView.y = offsetY - 215
                for subview in headerView.bottomScrollView.subviews {
                    let tableview = subview as! UITableView
                    tableview.isScrollEnabled = true
                }
            }else{
                headerView.y = 0
            }
        }
        
        
    }
}

extension UserDetailViewController: UserDetailBottomViewDelegate{
    /// 点击了用户或者话题
    private func didSelectTopicOrUser(){
        headerView.didSelectCellWithDongtai = { [weak self] (dongtai) in
            let dongtaiDetailVC = DongtaiDetailViewController()
            dongtaiDetailVC.dongtai = dongtai
            self!.navigationController?.pushViewController(dongtaiDetailVC, animated: true)
        }
    }
    
    //bottomView 底部按钮的点击
    func bottomView(clicked button: UIButton, bottomTab: BottomTab) {
        let bottomPushVC = UserDetailBottomPushController()
        bottomPushVC.navigationItem.title = "网页浏览"
        
        if bottomTab.children.count == 0 { //直接跳转到下一控制器
            bottomPushVC.url = bottomTab.value
            navigationController?.pushViewController(bottomPushVC, animated: true)
        }else{ //弹出 子视图
            //创建 UIStoryboard
            let sb = UIStoryboard(name: "\(UserDetailBottomPopController.self)", bundle: nil)
            //创建 UserDetailBottomPopController
            let popoverVC = sb.instantiateViewController(withIdentifier: "\(UserDetailBottomPopController.self)") as! UserDetailBottomPopController
            popoverVC.children = bottomTab.children
            popoverVC.modalPresentationStyle = .custom
            popoverVC.didSelectedChild = {[weak self] in
                bottomPushVC.url = $0.value
                self!.navigationController?.pushViewController(bottomPushVC, animated: true)
            }
            let popoverAnimator = PopoverAnimator()
            //转换 frame
            let rect = mybottomView.convert(button.frame, to: view)
            let popWidth = (screenWidth - CGFloat(userDetail!.bottom_tab.count + 1) * 20) / CGFloat(userDetail!.bottom_tab.count)
            let popX = CGFloat(button.tag) * (popWidth + 20) + 20
            let popHeight = CGFloat(bottomTab.children.count) * 40 + 25
            popoverAnimator.presentFrame = CGRect(x: popX, y: rect.origin.y - popHeight, width: popWidth, height: popHeight)
            popoverVC.transitioningDelegate = popoverAnimator
            present(popoverVC, animated: true, completion: nil)
        }
    }
}
