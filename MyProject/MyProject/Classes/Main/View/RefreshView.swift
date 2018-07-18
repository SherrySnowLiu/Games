//
//  RefreshView.swift
//  MyProject
//
//  Created by Sherry on 2018/7/16.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import MJRefresh

class RefreshAutoGifFooter: MJRefreshAutoGifFooter {
    //初始化
    override func prepare() {
        super.prepare()
        
        //设置控件的高度
        mj_h = 50
        //图片数组
        var images = [UIImage]()
        //遍历
        for index in 0..<8{
            let image = UIImage(named: "sendloading_18x18_\(index)")
            images.append(image!)
        }
        //设置空闲状态的图片
        setImages(images,for:.idle)
        //设置刷新状态的图片
        setImages(images,for:.refreshing)
        setTitle("正在努力加载", for: .idle)
        setTitle("正在努力加载", for: .pulling)
        setTitle("正在努力加载", for: .refreshing)
        setTitle("没有更多数据啦", for: .noMoreData)
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        gifView.x = 135
        gifView.centerY = stateLabel.centerY
    }
}
