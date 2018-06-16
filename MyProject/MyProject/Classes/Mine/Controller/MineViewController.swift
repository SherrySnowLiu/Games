//
//  MineViewController.swift
//  MyProject
//
//  Created by Sherry on 2018/6/16.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit

class MineViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.globalBackgroundColor()
    }

}

extension MineViewController{
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 10))
        view.backgroundColor = UIColor.globalBackgroundColor()
        return view
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = "测试"
        return cell
    }
}
