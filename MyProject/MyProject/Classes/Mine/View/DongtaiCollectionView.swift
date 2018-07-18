//
//  DongtaiCollectionView.swift
//  MyProject
//
//  Created by Sherry on 2018/7/12.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit

class DongtaiCollectionView: UICollectionView,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,NibLoadable {
    
    var isPostSmallVideo = false
        
    var thumbImageList = [ThumbImage](){
        didSet{
            reloadData()
        }
    }
    
    var largeImages = [LargeImage]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        delegate = self
        dataSource = self
        backgroundColor = UIColor.clear
        llx_registerCell(cell: DongtaiCollectionViewCell.self)
        collectionViewLayout = DongtaiCollectionViewFlowLayout()
        isScrollEnabled = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thumbImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.llx_dequeueReusableCell(indexPath: indexPath) as DongtaiCollectionViewCell
        cell.thumbImage = thumbImageList[indexPath.item]
        cell.isPostSmallVideo = isPostSmallVideo
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Calculate.collectionViewCellSize(thumbImageList.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let previewLargeImageVC = PreviewDongtaiLargeImageController()
        previewLargeImageVC.selectedIndex = indexPath.item
        previewLargeImageVC.images = largeImages
        UIApplication.shared.keyWindow?.rootViewController?.present(previewLargeImageVC, animated: false, completion: nil)
    }
}

class DongtaiCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        minimumLineSpacing = 5
        minimumInteritemSpacing = 5
    }
}
