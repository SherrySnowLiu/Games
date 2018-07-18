//
//  PreviewDongtaiLargeImageController.swift
//  MyProject
//
//  Created by Sherry on 2018/7/13.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import UIKit
import Kingfisher
import SVProgressHUD
import Photos

class PreviewDongtaiLargeImageController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    //索引标签
    @IBOutlet weak var indexLabel: UILabel!

    var images = [LargeImage]()
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        indexLabel.text = "\(selectedIndex + 1)/\(images.count)"
        collectionView.llx_registerCell(cell: DongtaiCollectionViewCell.self)
        view.layoutIfNeeded()
        collectionView.scrollToItem(at: IndexPath(item: selectedIndex, section: 0), at: .centeredHorizontally, animated: false)
    }
    @IBAction func saveImageButtonClicked(_ sender: UIButton) {
        let largeImage = images[selectedIndex]
        //下载图片
        ImageDownloader.default.downloadImage(with: URL(string: largeImage.url as String)!, retrieveImageTask: nil, options: nil, progressBlock: { (receivedSize, totalSize) in
            let progress = Float(receivedSize) / Float(totalSize)
            SVProgressHUD.showProgress(progress)
            SVProgressHUD.setBorderColor(.clear)
            SVProgressHUD.setForegroundColor(.white)
            
        }) { (image, error, cacheType, imageURL) in
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAsset(from: image!)
            }, completionHandler: { (success, error) in
                SVProgressHUD.dismiss()
                if success {
                    SVProgressHUD.showSuccess(withStatus: "保存成功!")
                }
            })
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension PreviewDongtaiLargeImageController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.llx_dequeueReusableCell(indexPath: indexPath) as DongtaiCollectionViewCell
        cell.largeImage = images[indexPath.item]
        cell.thumbImageView.contentMode = .scaleAspectFit
        cell.thumbImageView.layer.borderWidth = 0
        cell.backgroundColor = UIColor.black
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dismiss(animated: false, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width, height: collectionView.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        selectedIndex = Int(scrollView.contentOffset.x / collectionView.width + 0.5)
        indexLabel.text = "\(selectedIndex + 1)/\(images.count)"
    }
}
