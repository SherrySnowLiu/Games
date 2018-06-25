//
//  MyFirstSectionCell.swift
//  MyProject
//
//  Created by Sherry on 2018/6/20.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit

class MyFirstSectionCell: UITableViewCell,RegisterCellOrNib {
    //标题
    @IBOutlet weak var leftLabel: UILabel!
    //副标题
    @IBOutlet weak var rightLabel: UILabel!
    //右边箭头
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
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
