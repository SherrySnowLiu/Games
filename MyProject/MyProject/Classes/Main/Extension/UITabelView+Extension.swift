//
//  UITabelView+Extension.swift
//  MyProject
//
//  Created by Sherry on 2018/6/24.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit

extension UITableView{
    //注册cell的方法
    func llx_registerCell<T : UITableViewCell>(cell : T.Type) where T:RegisterCellOrNib {
        if let nib = T.nib {
            register(nib, forCellReuseIdentifier: T.identifier)
        }else{
            register(cell, forCellReuseIdentifier: T.identifier)
        }
    }
    //从缓存池出队已经存在的cell
    func llx_dequeueReusableCell<T : UITableViewCell>(indexPath : IndexPath) -> T where T:RegisterCellOrNib {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
}
