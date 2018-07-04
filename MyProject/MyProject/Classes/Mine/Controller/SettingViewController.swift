//
//  TableViewController.swift
//  MyProject
//
//  Created by Sherry on 2018/6/26.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit
import Kingfisher

class SettingViewController: UITableViewController {
    //存储plist文件里的数据
    var sections = [[SettingModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置ui
        setupUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = sections[section]
        return rows.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.llx_dequeueReusableCell(indexPath: indexPath) as SettingCell
        let rows = sections[indexPath.section]
        cell.setting = rows[indexPath.row]
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0://清理缓存
                //从沙盒中获取缓存大小
                calculateDiskCashSize(cell)
            case 2:
                cell.selectionStyle = .none //此cell无点击效果，点击无反应
            default:
                break
            }
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! SettingCell
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0://清理缓存
                clearCacheAlertController(cell)
            case 1://设置字体
                setupFontAlertController(cell)
            case 3://非WIFI 网络流量
                setupNetworkAlertController(cell)
            case 4://非WIFI 网络播放提醒
                setupPlayNoticeAlertController(cell)
            default:
                break
            }
        case 1:
            switch indexPath.row{
            case 0://离线下载
                let offlinedownVC = OfflineDownloadController()
                offlinedownVC.navigationItem.title = "离线下载"
                navigationController?.pushViewController(offlinedownVC, animated: true)
            default:
                break
            }
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 10))
//        view.backgroundColor = UIColor.globalBackgroundColor()
        view.theme_backgroundColor = "colors.tableViewBackgroundColor"
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}

extension SettingViewController{
    //非WIFI 网络播放提醒
    fileprivate func setupPlayNoticeAlertController(_ cell:SettingCell){
        let alertController = UIAlertController(title: "非WIFI网络播放提醒", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let everyAction = UIAlertAction(title: "每次提醒", style: .default) { (_) in
            cell.rightTitleLabel.text = "每次提醒"
        }
        let onceAction = UIAlertAction(title: "提醒一次", style: .default) { (_) in
            cell.rightTitleLabel.text = "提醒一次）"
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(everyAction)
        alertController.addAction(onceAction)
        present(alertController, animated: true, completion: nil)
    }
    //非WIFI 网络流量
    fileprivate func setupNetworkAlertController(_ cell:SettingCell){
        let alertController = UIAlertController(title: "非WIFI网络流量", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let bestAction = UIAlertAction(title: "最佳效果（下载大图）", style: .default) { (_) in
            cell.rightTitleLabel.text = "最佳效果（下载大图）"
        }
        let betterAction = UIAlertAction(title: "较省流量（智能下图）", style: .default) { (_) in
            cell.rightTitleLabel.text = "较省流量（智能下图）"
        }
        let leastAction = UIAlertAction(title: "极省流量（智能下图）", style: .default) { (_) in
            cell.rightTitleLabel.text = "极省流量（智能下图）"
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(bestAction)
        alertController.addAction(betterAction)
        alertController.addAction(leastAction)
        present(alertController, animated: true, completion: nil)
    }
    //设置字体大小
    fileprivate func setupFontAlertController(_ cell:SettingCell){
        let alertController = UIAlertController(title: "设置字体大小", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let smallAction = UIAlertAction(title: "小", style: .default) { (_) in
            cell.rightTitleLabel.text = "小"
        }
        let middleAction = UIAlertAction(title: "中", style: .default) { (_) in
            cell.rightTitleLabel.text = "中"
        }
        let bigAction = UIAlertAction(title: "大", style: .default) { (_) in
            cell.rightTitleLabel.text = "大"
        }
        let largeAction = UIAlertAction(title: "特大", style: .default) { (_) in
            cell.rightTitleLabel.text = "特大"
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(smallAction)
        alertController.addAction(middleAction)
        alertController.addAction(bigAction)
        alertController.addAction(largeAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //从沙盒中获取缓存大小
    fileprivate func calculateDiskCashSize(_ cell:SettingCell){
        let cache = KingfisherManager.shared.cache
        cache.calculateDiskCacheSize { (size) in
            //单位是字节，转换成M
            let sizeM = Double(size) / 1024.0 / 1024.0
            cell.rightTitleLabel.text = String(format: "%.2fM", sizeM)
        }
    }

    //弹出清理缓存的提示框
    fileprivate func clearCacheAlertController(_ cell:SettingCell){
        let alertController = UIAlertController(title: "确定清理所有缓存？问答草稿、离线下载及图片均会被清理", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .default) { (_) in
            let cache = KingfisherManager.shared.cache
            cache.clearDiskCache()
            cache.clearMemoryCache()
            cache.cleanExpiredDiskCache()
            cell.rightTitleLabel.text = "0.00M"
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension SettingViewController{
    //设置ui
    fileprivate func setupUI(){
        //plist文件路径
        let path = Bundle.main.path(forResource: "settingPlist", ofType: "plist")
        //plist文件中的数据
        let cellPlist = NSArray(contentsOfFile: path!) as! [Any]
//        for dicts in cellPlist {
//            let array = dicts as! [[String:Any]]
//            var rows = [SettingModel]()
//            for dict in array {
//                let setting = SettingModel.deserialize(from: dict as NSDictionary)
//                rows.append(setting!)
//            }
//            sections.append(rows)
//        }
        sections = cellPlist.compactMap({ section in
            (section as! [Any]).compactMap({ row in
                SettingModel.deserialize(from: row as?NSDictionary)
            })
        })
        tableView.llx_registerCell(cell: SettingCell.self)
        tableView.rowHeight = 44
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"
    }
}
