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
import SVProgressHUD

protocol NetworkToolProtocol {
    //-----------首页 home-------------
    //首页顶部新闻标题的数据
    static func loadHomeNewsTitle(completionHandler:@escaping (_ newsTitles:[homeNewTitle]) -> ())
    //-----------我的界面 mine-------------
    //我的界面 cell 的数据
    static func loadMyCellData(completionHandler:@escaping (_ sections:[[MyCellModel]]) -> ())
    //我的关注数据
    static func loadMyConcern(completionHandler:@escaping (_ concerns:[MyConcern]) -> ())
    //用户详情数据
    static func loadUserDetail(user_id : Int ,completionHandler:@escaping (_ userDetail:UserDetail) -> ())
    //已关注用户，取消关注
    static func loadRelationUnfollow(user_id : Int ,completionHandler:@escaping (_ user:ConcernUser) -> ())
    //点击关注按钮，关注用户
    static func loadRelationFollow(user_id : Int ,completionHandler:@escaping (_ user:ConcernUser) -> ())
    //点击了关注按钮，就会出现相关推荐
    static func loadRelationUserRecommend(user_id : Int ,completionHandler:@escaping (_ userCard:[UserCard]) -> ())
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
                    if let sections = data["sections"]?.arrayObject{
                        completionHandler(sections.compactMap({ item in
                        (item as! [Any]).compactMap({ row in
                                MyCellModel.deserialize(from: row as? Dictionary)
                            })
                        }))
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
                    completionHandler(datas.compactMap({
                        MyConcern.deserialize(from: $0 as? NSDictionary)
                    }))
                }
            }
        }
        
    }
    
    //用户详情数据
    static func loadUserDetail(user_id : Int ,completionHandler:@escaping (_ userDetail:UserDetail) -> ()){
        let url = BASE_URL + "/user/profile/homepage/v4/?"
        let params = ["user_id":user_id,
                      "device_id":device_id,
                      "iid":iid] as [String : Any]
        
        Alamofire.request(url,parameters:params).responseJSON { (response) in
            guard response.result.isSuccess else{
                return
            }
            if let value = response.result.value{
                let json = JSON(value)
//                print(json)
                guard json["message"] == "success" else{
                    if let data = json["data"].dictionaryObject{
                        SVProgressHUD.showInfo(withStatus: data["description"] as? String)
                        SVProgressHUD.setForegroundColor(UIColor.white)
                        SVProgressHUD.setBackgroundColor(UIColor(r: 0, g: 0, b: 0, alpha: 0.3))
                    }
                    return
                }
                if let data = json["data"].dictionaryObject{
                    let userDetail = UserDetail.deserialize(from: data as Dictionary)
                    completionHandler(userDetail!)
                }
            }
        }
    }
    
    //已关注用户，取消关注
    static func loadRelationUnfollow(user_id : Int ,completionHandler:@escaping (_ user:ConcernUser) -> ()){
        let url = BASE_URL + "/2/relation/unfollow/?"
        let params = ["user_id":user_id,
                      "device_id":device_id,
                      "iid":iid] as [String : Any]
        
        Alamofire.request(url,parameters:params).responseJSON { (response) in
            guard response.result.isSuccess else{
                return
            }
            if let value = response.result.value{
                let json = JSON(value)
                guard json["message"] == "success" else{
                    if let data = json["data"].dictionaryObject{
                        SVProgressHUD.showInfo(withStatus: data["description"] as? String)
                        SVProgressHUD.setForegroundColor(UIColor.white)
                        SVProgressHUD.setBackgroundColor(UIColor(r: 0, g: 0, b: 0, alpha: 0.3))
                    }
                    return
                }
                if let data = json["data"].dictionaryObject{
                    let user = ConcernUser.deserialize(from: data["user"] as? Dictionary)
                    completionHandler(user!)
                }
            }
        }
    }
    
    //点击关注按钮，关注用户
    static func loadRelationFollow(user_id : Int ,completionHandler:@escaping (_ user:ConcernUser) -> ()){
        let url = BASE_URL + "/2/relation/follow/v2/?"
        let params = ["user_id":user_id,
                      "device_id":device_id,
                      "iid":iid] as [String : Any]
        
        Alamofire.request(url,parameters:params).responseJSON { (response) in
            guard response.result.isSuccess else{
                return
            }
            if let value = response.result.value{
                let json = JSON(value)
                guard json["message"] == "success" else{
                    return
                }
                if let data = json["data"].dictionaryObject{
                    let user = ConcernUser.deserialize(from: data["user"] as? Dictionary)
                    completionHandler(user!)
                }
            }
        }
    }
    ///点击了关注按钮，就会出现相关推荐
    static func loadRelationUserRecommend(user_id : Int ,completionHandler:@escaping (_ userCard:[UserCard]) -> ()){
        let url = BASE_URL + "/user/relation/user_recommend/v1/supplement_recommends/?"
        let params = ["user_id":user_id,
                      "device_id":device_id,
                      "iid":iid,
                      "scene":"follow",
                      "source":"follow"] as [String : Any]
        
        Alamofire.request(url,parameters:params).responseJSON { (response) in
            guard response.result.isSuccess else{
                return
            }
            if let value = response.result.value{
                let json = JSON(value)
                print(json)
                guard json["err_no"] == 0 else{
                    return
                }
//                if let data = json["user_cards"].dictionaryObject{
//                    let userCard = UserCard.deserialize(from: data["user"] as? Dictionary)
//                    completionHandler([userCard!])
//                }
                if let user_cards = json["user_cards"].arrayObject {
                    completionHandler(user_cards.compactMap({ UserCard.deserialize(from: $0 as? Dictionary) }))
                }
            }
        }
    }
}

struct NetworkTool:NetworkToolProtocol {

}
