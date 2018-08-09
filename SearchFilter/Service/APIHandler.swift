//
//  APIHandler.swift
//  SearchFilter
//
//  Created by Muhammad Yaqub on 08/08/18.
//  Copyright © 2018 MiniProject. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import SwiftyJSON

class APIResp: Mappable {
    
    var status : StatusResp? = nil
    var data : JSON? = nil
    
    required init?(map: Map){
        
    }
    
    // Mappable
    func mapping(map: Map) {
        status      <- map["status"]
        data        <- map["data"]
    }
    
}

class StatusResp: Mappable {
    
    var error_code : Int? = 500
    var message : String? = ""
    
    required init?(map: Map){
        
    }
    
    // Mappable
    func mapping(map: Map) {
        
        error_code  <- map["code"]
        message     <- map["message"]
    }
    
}

class APIHandler{
    
    let baseURL: String = "https://ace.tokopedia.com"
    static let sharedInstance = APIHandler()
    
    func getProduct(offset:Int = 0, limit:Int = 10, callback : @escaping (APIResp) -> Void){
        
        let params: Parameters = [
            "q" : "samsung",
            "pmin" : "10000",
            "pmax" : "100000",
            "wholesale" : true,
            "official" : true,
            "fshop" : 2,
            "start" : offset,
            "rows" : limit
        ]
        
        Alamofire.request("\(baseURL)/search/v2.5/product", method: .get, parameters: params).responseObject { (response : DataResponse<APIResp>) in
            switch response.result{
            case .success(let apiResp):
                callback(apiResp)
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
}
