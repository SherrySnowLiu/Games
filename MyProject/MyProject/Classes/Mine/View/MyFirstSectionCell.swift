//
//  MyFirstSectionCell.swift
//  MyProject
//
//  Created by Sherry on 2018/6/20.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit

protocol MyFirstSectionCellDelegate:class {
    //点击了第几个cell，方法名不能用MyFirstSectionCell，和主方法名重复，会报错
    func MyFirstSectionCells(_ firstCell:MyFirstSectionCell,myConcern:MyConcern)
}

class MyFirstSectionCell: UITableViewCell,RegisterCellFromNib {
    weak var delegate : MyFirstSectionCellDelegate?
    
    //标题
    @IBOutlet weak var leftLabel: UILabel!
    //副标题
    @IBOutlet weak var rightLabel: UILabel!
    //右边箭头
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    //顶部view
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    //分割线
    @IBOutlet weak var separatorView: UIView!
    var myConcerns = [MyConcern](){
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    var myCellModel:MyCellModel? {
        didSet{
            leftLabel.text = myCellModel?.text
            rightLabel.text = myCellModel?.grey_text
        }
    }
    
    var myConcern:MyConcern?{
        didSet{
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.collectionViewLayout = MyConcernFlowLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.llx_registerCell(cell: MyConcernCell.self)
        
        //设置主题
        leftLabel.theme_textColor = "colors.black"
        rightLabel.theme_textColor = "colors.cellRightTextColor"
        rightImageView.theme_image = "images.cellRightArrow"
        separatorView.theme_backgroundColor = "colors.separatorViewColor"
        //设置cell的背景色
        theme_backgroundColor = "colors.cellBackgroundColor"
        topView.theme_backgroundColor = "colors.cellBackgroundColor"
        collectionView.theme_backgroundColor = "colors.cellBackgroundColor"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MyFirstSectionCell:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myConcerns.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.llx_dequeueReusableCell(indexPath: indexPath) as MyConcernCell
        cell.myConcern = myConcerns[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let myConcern = myConcerns[indexPath.item]
        delegate?.MyFirstSectionCells(self, myConcern: myConcern)
    }
}

class MyConcernFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        //每个cell的大小
        itemSize = CGSize(width: 58, height: 74)
        //横向间距
        minimumLineSpacing = 0
        //纵向间距
        minimumInteritemSpacing = 0
        //cell上下左右的间距
        sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        //设置水平滚动
        scrollDirection = .horizontal
    }
}

