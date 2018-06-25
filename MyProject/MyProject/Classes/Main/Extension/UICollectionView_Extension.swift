//
//  UICollectionView_Extension.swift
//  MyProject
//
//  Created by Sherry on 2018/6/24.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit

extension UICollectionView{
    //注册cell的方法
    func llx_registerCell<T : UICollectionViewCell>(cell : T.Type) where T:RegisterCellOrNib {
        if let nib = T.nib {
            register(nib, forCellWithReuseIdentifier: T.identifier)
        }else{
            register(cell, forCellWithReuseIdentifier: T.identifier)
        }
    }
    //从缓存池出队已经存在的cell
    func llx_dequeueReusableCell<T : UICollectionViewCell>(indexPath : IndexPath) -> T where T:RegisterCellOrNib {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}
