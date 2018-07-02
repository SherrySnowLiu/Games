//
//  NetworkTool.swift
//  MyProject
//
//  Created by Sherry on 2018/6/17.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol NetworkToolProtocol {
    //-----------首页 home-------------
    //首页顶部新闻标题的数据
    static func loadHomeNewsTitle(completionHandler:@escaping (_ newsTitles:[homeNewTitle]) -> ())
    //-----------我的界面 mine-------------
    //我的界面 cell 的数据
    static func loadMyCellData(completionHandler:@escaping (_ sections:[[MyCellModel]]) -> ())
    //我的关注数据
    static func loadMyConcern(completionHandler:@escaping (_ concerns:[MyConcern]) -> ())
}

extension NetworkToolProtocol{
    //-----------首页 home-------------
    //首页顶部新闻标题的数据
    static func loadHomeNewsTitle(completionHandler:@escaping (_ newsTitles:[homeNewTitle]) -> ()){
        let url = BASE_URL + "/article/category/get_subscribed/v1/?"
        let params = ["device_id":device_id,
                      "iid":iid]
        
        Alamofire.request(url,parameters:params).responseJSON{(response) in
            guard response.result.isSuccess else{
                return
            }
            if let value = response.result.value{
                let json = JSON(value)
                guard json["message"] == "success" else{
                    return
                }
                if let dataDict = json["data"].dictionary{
                    if let data = dataDict["data"]?.arrayObject{
                        var titles = [homeNewTitle]()
                        let jsonString = "{\"category\":\"\",\"name\":\"推荐\"}"
                        let recommend = homeNewTitle.deserialize(from: jsonString)
                        titles.append(recommend!)
                        for item in data{
                            let newsTitle = homeNewTitle.deserialize(from: item as? NSDictionary)
                            titles.append(newsTitle!)
                        }
                        completionHandler(titles)
                    }
                }
                
            }
        }
    }
    
    //-----------我的界面 mine-------------
    //我的界面 cell 的数据
    static func loadMyCellData(completionHandler:@escaping (_ sections:[[MyCellModel]]) -> ()){
        let url = BASE_URL + "/user/tab/tabs/?"
//        let url = BASE_URL + "/concern/v2/follow/my_follow/?"
        let params = ["device_id":device_id]
        
        Alamofire.request(url,parameters:params).responseJSON{(response) in
            guard response.result.isSuccess else{
                return
            }
            if let value = response.result.value{
                let json = JSON(value)
                guard json["message"] == "success" else{
                    return
                }
                if let data = json["data"].dictionary{
                    if let sections = data["sections"]?.array{
                        var sectionArray = [[MyCellModel]]()
                        for item in sections{
                            var rows = [MyCellModel]()
                            for row in item.arrayObject!{
                                let myCellModel = MyCellModel.deserialize(from: row as? Dictionary)
                                rows.append(myCellModel!)
                            }
                            sectionArray.append(rows)
                        }
                        completionHandler(sectionArray)
                    }
                }
            }
        }
    }
    //我的关注数据
    static func loadMyConcern(completionHandler:@escaping (_ concerns:[MyConcern]) -> ()){
        let url = BASE_URL + "/concern/v2/follow/my_follow/?"
        let params = ["device_id":device_id]

        Alamofire.request(url,parameters:params).responseJSON { (response) in
            guard response.result.isSuccess else{
                return
            }
            if let value = response.result.value{
                let json = JSON(value)
                guard json["message"] == "success" else{
                    return
                }
                if let datas = json["data"].arrayObject{
                    var conserns = [MyConcern]()
                    for data in datas{
                        let myCellModel = MyConcern.deserialize(from: data as? NSDictionary)
                        conserns.append(myCellModel!)
                    }
                    completionHandler(conserns)
                }
            }
        }
        
    }
}

struct NetworkTool:NetworkToolProtocol {

}
