//
//  UserDetailBottomPushController.swift
//  MyProject
//
//  Created by Sherry on 2018/7/9.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit
import WebKit

class UserDetailBottomPushController: UIViewController {
    var url:String?
    
    //显示导航栏
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let webView = WKWebView()
        webView.frame = view.bounds
        webView.load(URLRequest(url: URL(string: url!)!))
        view.addSubview(webView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
