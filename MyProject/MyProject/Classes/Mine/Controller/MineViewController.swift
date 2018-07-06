//
//  MineViewController.swift
//  MyProject
//
//  Created by Sherry on 2018/6/16.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MineViewController: UITableViewController {

    fileprivate let disposeBag = DisposeBag()
    var sections = [[MyCellModel]]()
    var concerns = [MyConcern]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = headerView
//        tableView.backgroundColor = UIColor.globalBackgroundColor()
        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"
        tableView.separatorStyle = .none
        tableView.llx_registerCell(cell: MyFirstSectionCell.self)
        tableView.llx_registerCell(cell: MyOtherCell.self)

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
            
            NetworkTool.loadMyConcern(completionHandler: { (concern) in
                self.concerns = concern
                let indexSet = IndexSet(integer:0)
                self.tableView.reloadSections(indexSet, with: .automatic)
            })
        }
        
        headerView.moreloginButton.rx.controlEvent(.touchUpInside).subscribe(onNext:{[weak self] in
            let storyboard = UIStoryboard(name: String(describing: MoreLoginViewController.self), bundle: nil)
            let moreLoginVC = storyboard.instantiateViewController(withIdentifier:String(describing: MoreLoginViewController.self)) as! MoreLoginViewController
            moreLoginVC.modalSize = (width:.full,height:.custom(size: Float(screenHeight - (isIPhoneX ? 44 : 20))))
            self!.present(moreLoginVC, animated: true, completion: nil)
        }).disposed(by: disposeBag)
//        addDisposableTo(disposeBag)
    }
    fileprivate lazy var headerView:NoLoginHeaderView = {
        let headerView = NoLoginHeaderView.headerView()
        return headerView
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

}

extension MineViewController{
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 0 : 10
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 10))
//        view.backgroundColor = UIColor.globalBackgroundColor()
        view.theme_backgroundColor = "colors.tableViewBackgroundColor"
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return (concerns.count == 0 || concerns.count == 1) ? 40 :114
        }
        return 40
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("section=",indexPath.section)
//        print("row=",indexPath.row)
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = tableView.llx_dequeueReusableCell(indexPath: indexPath) as MyFirstSectionCell

            let section = sections[indexPath.section]
            cell.myCellModel = section[indexPath.row]
           
            if concerns.count == 0 || concerns.count == 1{
                cell.collectionView.isHidden = true
            }
            if concerns.count == 1{
                cell.myConcern = concerns[0]
            }
            if concerns.count > 1{
                cell.myConcerns = concerns
            }
            cell.delegate = self
            return cell
        }
        
        let cell = tableView.llx_dequeueReusableCell(indexPath: indexPath) as MyOtherCell

        let section = sections[indexPath.section]
        let myCellModel = section[indexPath.row]
//        cell.textLabel?.text = myCellModel.text
        cell.leftLabel.text = myCellModel.text
        cell.rightLabel.text = myCellModel.grey_text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 3 {
            if indexPath.row == 1 {//系统设置
                let settingVC = SettingViewController()
                settingVC.navigationItem.title = "系统设置"
                navigationController?.pushViewController(settingVC, animated: true)
            }
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            //abs()取绝对值
            let totalOffset = kMyHeaderViewHeight + abs(offsetY)
//            let f = totalOffset / kMyHeaderViewHeight
//            headerView.bgImageView.frame = CGRect(x: -screenWidth * (f - 1) * 0.5, y: offsetY, width: screenWidth, height: totalOffset)
            headerView.bgImageView.frame = CGRect(x: 0, y: offsetY, width: screenWidth, height: totalOffset)
        }
        
    }
}
extension MineViewController:MyFirstSectionCellDelegate{
    //点击了第几个cell
    func MyFirstSectionCells(_ firstCell: MyFirstSectionCell, myConcern: MyConcern) {
        let userDetailVC = UserDetailViewController()
        userDetailVC.userId = myConcern.userid
        navigationController?.pushViewController(userDetailVC, animated: true)
    }

}

