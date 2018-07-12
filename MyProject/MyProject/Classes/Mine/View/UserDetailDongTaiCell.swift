//
//  UserDetailDongTaiCell.swift
//  MyProject
//
//  Created by Sherry on 2018/7/10.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit
import IBAnimatable

class UserDetailDongTaiCell: UITableViewCell,RegisterCellFromNib {
    
    var dongtai:UserDetailDongtai?{
        //赋值
        didSet{
            theme_backgroundColor = "colors.cellBackgroundColor"
            avatarImageView.kf.setImage(with: URL(string: dongtai!.user.avatar_url))
            nameLabel.text = dongtai!.user.screen_name
            likeButton.setTitle(dongtai!.diggCount, for: .normal)
            commentButton.setTitle(dongtai!.commentCount, for: .normal)
            forwardButton.setTitle(dongtai!.forwardCount, for: .normal)
            areaLabel.text = dongtai!.position.position + " "
            readCountLabel.text = dongtai!.readCount + "阅读"
            contentLabel.text = dongtai!.content
            contentLabelHeight.constant = dongtai!.contentH
            allContentLabel.isHidden = dongtai!.attributedCntentHeight == 110 ? false : true
            
            //防止因为 cell 重用机制，导致书记错乱现象出现
            if middleView.contains(postVideoOrArticleView) {
                postVideoOrArticleView.removeFromSuperview()
            }
            if middleView.contains(collectionView){
                collectionView.removeFromSuperview()
            }
            if middleView.contains(originThreadView){
                originThreadView.removeFromSuperview()
            }
            
            switch dongtai!.item_type {
            case .postVideoOrArticle, .postVideo, .answerQuestion, .proposeQuestion, .forwardArticle, .postContentAndVideo: //发布了文章或视频
                middleView.addSubview(postVideoOrArticleView)
                postVideoOrArticleView.frame = CGRect(x: 15, y: 0, width: screenWidth - 30, height: middleView.height)
                postVideoOrArticleView.group = dongtai!.group
            case .postContent, .postSmallVideo: //发布了文字内容
                middleView.addSubview(collectionView)
                collectionView.frame = CGRect(x: 15, y: 0, width: dongtai!.collectionViewW, height: dongtai!.collectionViewH)
                collectionView.thumbImageList = dongtai!.thumb_image_list
            case .commentOrQuoteContent: //引用或评论
                middleView.addSubview(originThreadView)
                originThreadView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: dongtai!.origin_thread.height)
                originThreadView.originthread = dongtai!.origin_thread
            case .commentOrQuoteOthers:
                print("")
            }
            layoutIfNeeded()
        }
    }
    
    ///懒加载 评论或引用
    private lazy var originThreadView:DongtaiOriginThreadView = {
        let originThreadView = DongtaiOriginThreadView.loadViewFromNib()
        return originThreadView
    }()
    
    ///懒加载 发布视频或文章
    private lazy var postVideoOrArticleView:PostVideoOrArticleView = {
        let postVideoOrArticleView = PostVideoOrArticleView.loadViewFromNib()
        return postVideoOrArticleView
    }()
    
    ///懒加载 发布视频或文章
    private lazy var collectionView:DongtaiCollectionView = {
        let collectionView = DongtaiCollectionView.loadViewFromNib()
//        collectionView.llx_registerCell(cell: DongtaiCollectionViewCell.self)
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.showsVerticalScrollIndicator = false
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.isScrollEnabled = false
//        collectionView.theme_backgroundColor = "colors.cellBackgroundColor"
        return collectionView
    }()
    
    //头像
    @IBOutlet weak var avatarImageView: AnimatableImageView!
    //用户名
    @IBOutlet weak var nameLabel: UILabel!
    //修改时间
    @IBOutlet weak var modifyTimeLabel: UILabel!
    //更多按钮
    @IBOutlet weak var moreButton: UIButton!
    //喜欢按钮
    @IBOutlet weak var likeButton: UIButton!
    //评论按钮
    @IBOutlet weak var commentButton: UIButton!
    //转发按钮
    @IBOutlet weak var forwardButton: UIButton!
    //位置、阅读数量
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var readCountLabel: UILabel!
    ///内容
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentLabelHeight: NSLayoutConstraint!
    ///全文
    @IBOutlet weak var allContentLabel: UILabel!
    //中间的view
    @IBOutlet weak var middleView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.theme_textColor = "colors.black"
        likeButton.theme_setTitleColor("colors.black", forState: .normal)
        commentButton.theme_setTitleColor("colors.black", forState: .normal)
        forwardButton.theme_setTitleColor("colors.black", forState: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//extension UserDetailDongTaiCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return dongtai!.thumb_image_list.count
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.llx_dequeueReusableCell(indexPath: indexPath) as DongtaiCollectionViewCell
//        cell.thumbImage = dongtai!.thumb_image_list[indexPath.item]
//        return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return Calculate.collectionViewCellSize(dongtai!.thumb_image_list.count)
//    }
//}

//class DongtaiCollectionViewFlowLayout: UICollectionViewFlowLayout {
//    override func prepare() {
//        super.prepare()
//        minimumLineSpacing = 5
//        minimumInteritemSpacing = 5
//    }
//}
