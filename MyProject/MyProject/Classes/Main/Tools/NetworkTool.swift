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
    //-----------我的界面 mine-------------
    //我的界面 cell 的数据
    static func loadMyCellData(completionHandler:@escaping (_ sections:[[MyCellModel]]) -> ())
    //我的关注数据
    static func loadMyConcern()
}

extension NetworkToolProtocol{
    
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
                    print(data)
                    if let sections = data["sections"]?.array{
                        var sectionArray = [[MyCellModel]]()
                        print("data:",data)
                        for item in sections{
                            print("item:",item)
                            var rows = [MyCellModel]()
                            for row in item.arrayObject!{
                                print("row:",row)
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
    static func loadMyConcern(){
        
    }
}


struct NetworkTool:NetworkToolProtocol {
    
}
