//
//  WeitoutiaoViewController.swift
//  MyProject
//
//  Created by Sherry on 2018/7/13.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit

class WeitoutiaoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension WeitoutiaoViewController{
    ///设置 ui
    private func setupUI(){
        view.theme_backgroundColor = "colors.cellBackgroundColor"
        
        if UserDefaults.standard.bool(forKey: isNight) { //夜间
            MyThemeStyle.setNightNavigationStyle(self)
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "follow_title_profile_night_18x18_"), style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        }else{ //日间
            MyThemeStyle.setDayNavigationStyle(self)
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "follow_title_profile_18x18_"), style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        }
        //注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(reciveDayOrNightButtonClicked(notification:)), name: NSNotification.Name(rawValue: "dayOrNightButtonClicked"), object: nil)
    }
    
    //接收按钮点击的通知
    @objc private func reciveDayOrNightButtonClicked(notification:Notification){
        let selected = notification.object as! Bool
        if selected {//true，设置为夜间
            MyThemeStyle.setNightNavigationStyle(self)
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "follow_title_profile_night_18x18_"), style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        }else{
            MyThemeStyle.setDayNavigationStyle(self)
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "follow_title_profile_18x18_"), style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        }
    }
    
    @objc private func rightBarButtonItemClicked() {
        
    }
}

