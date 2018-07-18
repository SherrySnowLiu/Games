//
//  UserDetailHeaderView.swift
//  MyProject
//
//  Created by Sherry on 2018/7/4.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit
import IBAnimatable
import SVProgressHUD

class UserDetailHeaderView: UIView,NibLoadable {
    //点击了用户
    var didSelectUserUID : ((_ uid : Int)->())?
    
    /// 刷新的指示器
    var maxCursor = 0
    
    var wendaCursor = ""
    
    //当前点击的 toptab 的索引，点击了第几个
    var currentSelectedIndex = 0
    //当前的 toptab 的类型
    var currentTopTabType:TopTabType = .dongtai{
        didSet{
            let tableView = bottomScrollView.subviews[currentSelectedIndex] as! UITableView
            switch currentTopTabType {
            case .dongtai:
                setupFooter(tableView) { (dongtais) in
                    self.dongtais += dongtais
                    tableView.reloadData()
                }
                if !isDongtaisShown{
                    isDongtaisShown = true
                    tableView.reloadData()
                }
                //获取用户详情的问答列表数据
                NetworkTool.loadUserDetailWendaList(user_id: userDetail!.user_id, cursor: wendaCursor) { (cursor,wendas) in
                    self.wendas = wendas
                    self.wendaCursor = cursor
                }
            case .article:
                setupFooter(tableView) { (dongtais) in
                    self.articles += dongtais
                    tableView.reloadData()
                }
                if !isArticlesShown{
                    isArticlesShown = true
                    tableView.mj_footer.beginRefreshing()
                }
            case .video:
                setupFooter(tableView) { (dongtais) in
                    self.videos += dongtais
                    tableView.reloadData()
                }
                if !isVideosShown{
                    isVideosShown = true
                    tableView.mj_footer.beginRefreshing()
                }
            case .iesVideo:
                setupFooter(tableView) { (dongtais) in
                    self.iesVideos += dongtais
                    tableView.reloadData()
                }
                if !isIesVideosShown{
                    isIesVideosShown = true
                    tableView.mj_footer.beginRefreshing()
                }
            case .wenda:
                tableView.mj_footer = RefreshAutoGifFooter(refreshingBlock: {[weak self] in
                    NetworkTool.loadUserDetailLoadMoreWendaList(userId: self!.userDetail!.user_id, cursor: self!.wendaCursor, completionHandler: { (cursor, wendas) in
                        self!.wendaCursor = cursor
                        if tableView.mj_footer.isRefreshing{
                            tableView.mj_footer.endRefreshing()
                        }
                        tableView.mj_footer.pullingPercent = 0.0
                        if wendas.count == 0 {
                            tableView.mj_footer.endRefreshingWithNoMoreData()
                            SVProgressHUD.showInfo(withStatus: "没有更多数据啦!")
                            return
                        }
                        self!.wendas += wendas
                        tableView.reloadData()
                    })
                })
                
                if !isWendasShown{
                    isWendasShown = true
                    tableView.reloadData()
                }
            }
        }
    }
    //设置footer
    private func setupFooter(_ tableView:UITableView,completionHandler:@escaping ((_ datas:[UserDetailDongtai])->())){
        tableView.mj_footer = RefreshAutoGifFooter(refreshingBlock: {[weak self] in
            NetworkTool.loadUserDetailDongtaiList(user_id: self!.userDetail!.user_id, maxCursor: self!.maxCursor, completionHandler: { (cursor, dongtais) in
                if tableView.mj_footer.isRefreshing{
                    tableView.mj_footer.endRefreshing()
                }
                tableView.mj_footer.pullingPercent = 0.0
                if dongtais.count == 0 {
                    tableView.mj_footer.endRefreshingWithNoMoreData()
                    SVProgressHUD.showInfo(withStatus: "没有更多数据啦!")
                    return
                }
                completionHandler(dongtais)
                self!.maxCursor = cursor
//                self!.dongtais = dongtais
//                tableView.reloadData()
            })
        })
    }
    
    ///动态数据数组
    var dongtais = [UserDetailDongtai]()
    var articles = [UserDetailDongtai]()
    var videos = [UserDetailDongtai]()
    var wendas = [UserDetailWenda]()
    var iesVideos = [UserDetailDongtai]()
    //记录当前的数据是否刷新过
    var isDongtaisShown = false
    var isArticlesShown = false
    var isVideosShown = false
    var isWendasShown = false
    var isIesVideosShown = false
    
    
    var userDetail:UserDetail?{
        didSet{
            backgroundImageView.kf.setImage(with: URL(string: userDetail!.bg_img_url)!)
            avatarImageView.kf.setImage(with: URL(string: userDetail!.avatar_url)!)
            vImageView.isHidden = !userDetail!.user_verified
            nameLabel.text = userDetail!.screen_name
            if userDetail!.verified_agency == "" {
                verifiedAgnecyLabelHeight.constant = 0
                verifiedAgencyLabelTop.constant = 0
            } else {
                verifiedAgencyLabel.text = userDetail!.verified_agency + "："
                verfifiedContentLabel.text = userDetail!.verified_content
            }
            concernButton.isSelected = userDetail!.is_following
//            concernButton.theme_backgroundColor = userDetail!.is_following ? "colors.userDetailFollowingConcernBtnBgColor":"colors.userDetailConcernBtnBgColor"
            concernButton.theme_backgroundColor = userDetail!.is_following ? "colors.userDetailFollowingConcernBtnBgColor":"colors.globalRedColor"
            concernButton.borderColor = userDetail!.is_following ? .grayColor232() : .globalRedColor()
            concernButton.borderWidth = userDetail!.is_following ? 1 : 0
            if userDetail!.area == "" {
                areaButton.isHidden = true
                areaButtonHeight.constant = 0
                areaButtonTop.constant = 0
            } else {
                areaButton.setTitle(userDetail!.area, for: .normal)
            }
            descriptionLabel.text = userDetail!.description as String
            if userDetail!.descriptionHeight > 21 {
                unfoldButton.isHidden = false
                unfoldButtonWidth.constant = 40.0
            }
            //推荐按钮的约束
            recommendButtonWidth.constant = 0
            recommendButtonTrailing.constant = 10.0
            followersCountLabel.text = userDetail!.followersCount
            followingsCountLabel.text = userDetail!.followingsCount
            
            if userDetail!.top_tab.count > 0 {
                //添加按钮和 tableview
                for (index,topTab) in userDetail!.top_tab.enumerated(){
                    //按钮
                    let button = UIButton(frame: CGRect(x: CGFloat(index) * topTabButtonWidth, y: 0, width: topTabButtonWidth, height: scrollView.height))
                    button.setTitle(topTab.show_name, for: .normal)
                    button.tag = index
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                    button.theme_setTitleColor("colors.black", forState: .normal)
                    button.theme_setTitleColor("colors.globalRedColor", forState: .selected)
                    button.addTarget(self, action: #selector(topTabButtonClicked(button:)), for: .touchUpInside)
                    scrollView.addSubview(button)
                    
                    if index == 0 {
                        button.isSelected = true
                        privorButton = button
                    }
                    let tableView = UITableView(frame: CGRect(x: CGFloat(index) * screenWidth, y: 0, width: screenWidth, height: bottomScrollView.height))
                    if userDetail!.bottom_tab.count == 0 {
                        tableView.contentInset = UIEdgeInsetsMake(0, 0, 34, 0)
                    }
                    if topTab.type == .wenda {
                        tableView.llx_registerCell(cell: UserDetailWendaCell.self)
                    }else{
                        tableView.llx_registerCell(cell: UserDetailDongTaiCell.self)
                    }
                    
                    tableView.delegate = self
                    tableView.dataSource = self
                    tableView.isScrollEnabled = false
                    tableView.showsVerticalScrollIndicator = false
                    tableView.separatorStyle = .none
                    tableView.tableFooterView = UIView()
                    bottomScrollView.addSubview(tableView)
                    if index == userDetail!.top_tab.count - 1 {
                        scrollView.contentSize = CGSize(width: button.frame.maxX, height: scrollView.height)
                        bottomScrollView.contentSize = CGSize(width: tableView.frame.maxX, height: bottomScrollView.height)
                    }
                }
                scrollView.addSubview(indicatorView)
            }else{
                topTabHeight.constant = 0
                topTabView.isHidden = true
            }
           
            layoutIfNeeded()
        }
    }

    //topTab 指示条
    private lazy var indicatorView:UIView = {
        let indicatorView = UIView(frame: CGRect(x: (topTabButtonWidth - topTabindicatorWidth) * 0.5, y: topTabView.height - 3, width: topTabindicatorWidth, height: topTabindicatorHeight))
        indicatorView.theme_backgroundColor = "colors.globalRedColor"
        return indicatorView
    }()
    
    ///懒加载 自定义的推荐view
    fileprivate lazy var relationRecommendView:RelationRecommendView={
        let relationRecommendView = RelationRecommendView.loadViewFromNib()
        return relationRecommendView
    }()
    
    weak var privorButton = UIButton()
    ///点击了cell
    var didSelectCellWithDongtai:((_ dongtai:UserDetailDongtai)->())?
    
    //背景图片
    @IBOutlet weak var backgroundImageView: UIImageView!
    //背景图片顶部约束
    @IBOutlet weak var bgImageViewTop: NSLayoutConstraint!
    //用户头像
    @IBOutlet weak var avatarImageView: UIImageView!
    //V 图标
    @IBOutlet weak var vImageView: UIImageView!
    //用户名
    @IBOutlet weak var nameLabel: UILabel!
    //头条号图标
    @IBOutlet weak var toutiaohaoImageView: UIImageView!
    //发私信按钮
    @IBOutlet weak var sendMailButton: UIButton!
    //关注按钮
    @IBOutlet weak var concernButton: AnimatableButton!
    //推荐
    @IBOutlet weak var recommendButton: AnimatableButton!
    @IBOutlet weak var recommendButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var recommendButtonTrailing: NSLayoutConstraint!
    //推荐 view
    @IBOutlet weak var recommendView: UIView!
    @IBOutlet weak var recommendViewHeight: NSLayoutConstraint!
    //头条认证
    @IBOutlet weak var verifiedAgencyLabel: UILabel!
    @IBOutlet weak var verifiedAgnecyLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var verifiedAgencyLabelTop: NSLayoutConstraint!
    //认证内容
    @IBOutlet weak var verfifiedContentLabel: UILabel!
    //地区
    @IBOutlet weak var areaButton: UIButton!
    @IBOutlet weak var areaButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var areaButtonTop: NSLayoutConstraint!
    //描述内容
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionLabelHeight: NSLayoutConstraint!
    //展开按钮
    @IBOutlet weak var unfoldButton: UIButton!
    @IBOutlet weak var unfoldButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var unfoldButtonTrailing: NSLayoutConstraint!
    //关注数量
    @IBOutlet weak var followingsCountLabel: UILabel!
    //粉丝数量
    @IBOutlet weak var followersCountLabel: UILabel!
    //文章、视频、问答
    @IBOutlet weak var topTabView: UIView!
    @IBOutlet weak var topTabHeight: NSLayoutConstraint!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    //底层view
    @IBOutlet weak var baseView: UIView!
    ///底部的 scrollview
    @IBOutlet weak var bottomScrollView: UIScrollView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        concernButton.setTitle("关注", for: .normal)
        concernButton.setTitle("已关注", for: .selected)
        //设置主题颜色
        theme_backgroundColor = "colors.cellBackgroundColor"
        topTabView.theme_backgroundColor = "colors.cellBackgroundColor"
        separatorView.theme_backgroundColor = "colors.separatorViewColor"
        nameLabel.theme_textColor = "colors.black"
        sendMailButton.theme_setTitleColor("colors.userDetailSendMailTextColor", forState: .normal)
        unfoldButton.theme_setTitleColor("colors.userDetailSendMailTextColor", forState: .normal)
        followersCountLabel.theme_textColor = "colors.userDetailSendMailTextColor"
        followingsCountLabel.theme_textColor = "colors.userDetailSendMailTextColor"
//        concernButton.theme_setTitleColor("colors.userDetailConcernBtnBgColor", forState: .normal)
        concernButton.theme_setTitleColor("colors.userDetailConcernButtonTextColor", forState: .normal)
        concernButton.theme_setTitleColor("colors.userDetailConcernButtonSelectedTextColor", forState: .selected)
        verifiedAgencyLabel.theme_textColor = "colors.verifiedAgencyTextColor"
        verfifiedContentLabel.theme_textColor = "colors.black"
        descriptionLabel.theme_textColor = "colors.black"
        toutiaohaoImageView.theme_image = "images.toutiaohao"
        
        NotificationCenter.default.addObserver(self, selector: #selector(receivedConcernButtonClicked(notification:)), name: NSNotification.Name(rawValue: NavigationBarConcernButtonClicked), object: nil)
        
        SVProgressHUD.configuration()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    //发私信按钮
    @IBAction func sendMailButtonClicked() {
        let storyboard = UIStoryboard(name: String(describing: MoreLoginViewController.self), bundle: nil)
        let moreLoginVC = storyboard.instantiateViewController(withIdentifier:String(describing: MoreLoginViewController.self)) as! MoreLoginViewController
        moreLoginVC.modalSize = (width:.full,height:.custom(size: Float(screenHeight - (isIPhoneX ? 44 : 20))))
        UIApplication.shared.keyWindow?.rootViewController?.present(moreLoginVC, animated: true, completion: nil)
    }
    
    //topTab 按钮点击事件
    @objc func topTabButtonClicked(button:UIButton) {
        privorButton?.isSelected = false
        button.isSelected = !button.isSelected
        UIView.animate(withDuration: 0.25, animations: {
            self.indicatorView.centerX = button.centerX
            self.bottomScrollView.contentOffset = CGPoint(x: CGFloat(button.tag) * screenWidth, y: 0)
        }) { (_) in
            self.privorButton = button
        }
        //获取索引
        currentSelectedIndex = button.tag
        //取出当前点击的 toptab，赋值给currentTopTabType
        let topTab = userDetail!.top_tab[button.tag]
        currentTopTabType = topTab.type
    }
    
    //关注按钮
    @IBAction func concernButtonClicked(_ sender: AnimatableButton) {
//        sender.isSelected = !sender.isSelected
        if sender.isSelected{ //已关注，点击取消关注
            NetworkTool.loadRelationUnfollow(user_id: userDetail!.user_id) { (_) in
                sender.isSelected = !sender.isSelected
                self.concernButton.theme_backgroundColor = "colors.globalRedColor"
                self.recommendButton.isHidden = true
                self.recommendButton.isSelected = false
                self.recommendButtonWidth.constant = 0
                self.recommendButtonTrailing.constant = 0
                self.recommendViewHeight.constant = 0
                UIView.animate(withDuration: 0.25, animations: {
                    self.recommendButton.imageView?.transform = .identity
                    self.layoutIfNeeded()
                })
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: UserDetailHeaderViewButtonClicked), object: self,userInfo:["isSelected":sender.isSelected])
            }
        }else{//未关注，点击则关注该用户
            NetworkTool.loadRelationFollow(user_id: userDetail!.user_id) { (_) in
                sender.isSelected = !sender.isSelected
                self.concernButton.theme_backgroundColor = "colors.userDetailFollowingConcernBtnBgColor"
                self.recommendButton.isHidden = false
                self.recommendButton.isSelected = false
                self.recommendButtonWidth.constant = 28.0
                self.recommendButtonTrailing.constant = 15.0
                self.recommendViewHeight.constant = 233.0
                UIView.animate(withDuration: 0.25, animations: {
                    self.layoutIfNeeded()
                }) { (_) in
                    NetworkTool.loadRelationUserRecommend(user_id: self.userDetail!.user_id, completionHandler: { (userCards) in
                        self.recommendView.addSubview(self.relationRecommendView)
                        self.relationRecommendView.userCards = userCards
                    })
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: UserDetailHeaderViewButtonClicked), object: self,userInfo:["isSelected":sender.isSelected])
                }
            }
        }
    }
    ///接收到了关注按钮的点击
    @objc private func receivedConcernButtonClicked(notification:NSNotification){
        let userInfo = notification.userInfo as! [String:Any]
        let isSelected = userInfo["isSelected"] as! Bool
        concernButton.isSelected = isSelected
        concernButton.theme_backgroundColor = isSelected ? "colors.userDetailFollowingConcernBtnBgColor":"colors.globalRedColor"
        concernButton.borderColor = isSelected ? UIColor.grayColor232(): UIColor.globalRedColor()
        concernButton.borderWidth = isSelected ? 1 : 0
        
    }
    
    //推荐关注按钮
    @IBAction func recommendButtonClicked(_ sender: AnimatableButton) {
        sender.isSelected = !sender.isSelected
        recommendViewHeight.constant = sender.isSelected ? 0 : 223.0
        UIView.animate(withDuration: 0.25, animations: {
            sender.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(sender.isSelected ? Double.pi : 0))
            self.layoutIfNeeded()
        })
    }
    
    //展开按钮
    @IBAction func unfoldButtonClicked() {
        unfoldButton.isHidden = true
        unfoldButtonWidth.constant = 0
        relationRecommendView.labelHeight.constant = 0
        relationRecommendView.layoutIfNeeded()
        descriptionLabelHeight.constant = userDetail!.descriptionHeight
        UIView.animate(withDuration: 0.25, animations: {
            self.layoutIfNeeded()
        })
    }
}
extension UserDetailHeaderView : UITableViewDelegate,UITableViewDataSource{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            for subview in bottomScrollView.subviews {
                let tableView = subview as! UITableView
                tableView.isScrollEnabled = false
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch currentTopTabType {
        case .dongtai:
            return cellFor(tableView, at: indexPath, with: dongtais)
        case .article:
            return cellFor(tableView, at: indexPath, with: articles)
        case .iesVideo:
            return cellFor(tableView, at: indexPath, with: iesVideos)
        case .video:
            return cellFor(tableView, at: indexPath, with: videos)
        case .wenda:
            let cell = tableView.llx_dequeueReusableCell(indexPath: indexPath) as UserDetailWendaCell
            cell.wenda = wendas[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch currentTopTabType {
        case .dongtai:
            didSelectCellWithDongtai?(dongtais[indexPath.row])
        case .article:
            didSelectCellWithDongtai?(articles[indexPath.row])
        case .iesVideo:
            didSelectCellWithDongtai?(iesVideos[indexPath.row])
        case .video:
            didSelectCellWithDongtai?(videos[indexPath.row])
        case .wenda:
            print("")
        }
    }
    
    private func cellFor(_ tableView:UITableView,at indexPath:IndexPath,with datas:[UserDetailDongtai])->UserDetailDongTaiCell{
        let cell = tableView.llx_dequeueReusableCell(indexPath: indexPath) as UserDetailDongTaiCell
        cell.dongtai = datas[indexPath.row]
        cell.didSelectUserUID = { [weak self] (uid) in
            self!.didSelectUserUID?(uid)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch currentTopTabType {
        case .dongtai:
            return dongtais.count
        case .article:
            return articles.count
        case .iesVideo:
            return iesVideos.count
        case .video:
            return videos.count
        case .wenda:
            return wendas.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch currentTopTabType {
        case .dongtai:
            return cellHeight(with: dongtais[indexPath.row])
        case .article:
            return cellHeight(with: articles[indexPath.row])
        case .iesVideo:
            return cellHeight(with: iesVideos[indexPath.row])
        case .video:
            return cellHeight(with: videos[indexPath.row])
        case .wenda:
            let wenda = wendas[indexPath.row]
            return wenda.cellHeight
        }
    }
    
    private func cellHeight(with dongtai:UserDetailDongtai)->CGFloat{
        return dongtai.cellHeight
    }
    
}
