//
//  DongtaiDetailViewController.swift
//  MyProject
//
//  Created by Sherry on 2018/7/17.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit

class DongtaiDetailViewController: UITableViewController {
    
    var dongtai = UserDetailDongtai(){
        didSet{
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //显示导航栏
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    
    //懒加载
    private lazy var navigationBar:DongtaiNavigationBar = {
        let navigationBar = DongtaiNavigationBar.loadViewFromNib()
        return navigationBar
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}
extension DongtaiDetailViewController{
    func setupUI(){
        tableView.theme_backgroundColor = "colors.cellBackgroundColor"
        navigationItem.titleView = navigationBar
        //判断是否是夜间
        MyThemeStyle.setNavigationBarStyle(self, isNight: UserDefaults.standard.bool(forKey: isNight))
        //添加导航栏右侧按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: UserDefaults.standard.bool(forKey: isNight) ? "follow_title_profile_night_18x18_" : "follow_title_profile_18x18_"), style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        //注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(reciveDayOrNightButtonClicked(notification:)), name: NSNotification.Name(rawValue: "dayOrNightButtonClicked"), object: nil)
    }
    
    //接收按钮点击的通知
    @objc private func reciveDayOrNightButtonClicked(notification:Notification){
        let selected = notification.object as! Bool
        //判断是否是夜间
        MyThemeStyle.setNavigationBarStyle(self, isNight: selected)
        //添加导航栏右侧按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: selected ? "follow_title_profile_night_18x18_" : "follow_title_profile_18x18_"), style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        //        if selected {//true，设置为夜间
        //            MyThemeStyle.setNightNavigationStyle(self)
        //            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "follow_title_profile_night_18x18_"), style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        //        }else{
        //            MyThemeStyle.setDayNavigationStyle(self)
        //            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "follow_title_profile_18x18_"), style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        //        }
    }
    @objc private func rightBarButtonItemClicked() {
        
    }
}
