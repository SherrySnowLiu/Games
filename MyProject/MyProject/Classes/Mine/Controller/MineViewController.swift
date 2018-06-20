//
//  MineViewController.swift
//  MyProject
//
//  Created by Sherry on 2018/6/16.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit

class MineViewController: UITableViewController {

    var sections = [[MyCellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.globalBackgroundColor()
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: String(describing:MyOtherCell.self), bundle: nil), forCellReuseIdentifier: String(describing:MyOtherCell.self))
        tableView.register(UINib(nibName: String(describing:MyFirstSectionCell.self), bundle: nil), forCellReuseIdentifier: String(describing:MyFirstSectionCell.self))
        //获取我的 cell 的数据
        NetworkTool.loadMyCellData { (sections) in
            let string = "{\"text\":\"我的关注\",\"grey_text\":\"\"}"
            let myConcern = MyCellModel.deserialize(from: string)
            var myConcerns = [MyCellModel]()
            myConcerns.append(myConcern!)
            self.sections.append(myConcerns)
            self.sections += sections
            
            //刷新数据
            self.tableView.reloadData()
        }
    }

}

extension MineViewController{
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 0 : 10
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 10))
        view.backgroundColor = UIColor.globalBackgroundColor()
        return view
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("section=",indexPath.section)
        print("row=",indexPath.row)
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:MyFirstSectionCell.self)) as! MyFirstSectionCell
            let section = sections[indexPath.section]
            let myCellModel = section[indexPath.row]
            cell.leftLabel.text = myCellModel.text
            cell.rightLabel.text = myCellModel.grey_text
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:MyOtherCell.self)) as! MyOtherCell
        let section = sections[indexPath.section]
        let myCellModel = section[indexPath.row]
//        cell.textLabel?.text = myCellModel.text
        cell.leftLabel.text = myCellModel.text
        cell.rightLabel.text = myCellModel.grey_text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
