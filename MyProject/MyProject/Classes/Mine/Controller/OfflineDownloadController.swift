//
//  OfflineDownloadControllerTableViewController.swift
//  MyProject
//
//  Created by Sherry on 2018/6/27.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit

class OfflineDownloadController: UITableViewController {
//标题数组
    fileprivate var titles = [homeNewTitle]()
    //标题数据表
    fileprivate let newsTitleTable = NewTitleTable()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.llx_registerCell(cell: OfflineDownloadCell.self)
        tableView.rowHeight = 44
        tableView.theme_separatorColor = "colors.separatorViewColor"
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        //从数据库中取出左右数据，取值给标题数组titles
        titles = newsTitleTable.selectAll()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        view.theme_backgroundColor = "colors.tableViewBackgroundColor"
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: screenWidth, height: 44))
        label.text = "我的频道"
        label.theme_textColor = "colors.black"
        let separatorView = UIView(frame: CGRect(x: 0, y: 43, width: screenWidth, height: 1))
        separatorView.theme_backgroundColor = "colors.separatorViewColor"
        view.addSubview(label)
        view.addSubview(separatorView)
        return view
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.llx_dequeueReusableCell(indexPath: indexPath) as OfflineDownloadCell
        let newsTitle = titles[indexPath.row]
        cell.titleLabel.text = newsTitle.name
        cell.rightImageView.theme_image = newsTitle.selected ? "images.air_download_option_press" : "images.air_download_option"
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //取出数组中的第 row 个对象
        var homeNewsTitle = titles[indexPath.row]
        //取反
        homeNewsTitle.selected = !homeNewsTitle.selected
        //取出第 row 个cell
        let cell = tableView.cellForRow(at: indexPath) as! OfflineDownloadCell
        //改变 cell的图片
        cell.rightImageView.theme_image = homeNewsTitle.selected ? "images.air_download_option_press" : "images.air_download_option"
        //替换数组中的数据
        titles[indexPath.row] = homeNewsTitle
        //更新数据库中的数据
        newsTitleTable.update(homeNewsTitle)
//        tableView.reloadRows(at: [indexPath], with: .none)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
