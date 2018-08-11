//
//  ProductService.swift
//  SearchFilter
//
//  Created by Muhammad Yaqub on 09/08/18.
//  Copyright © 2018 MiniProject. All rights reserved.
//

import Foundation

class ProductService{
    
    func getProduct(offset:Int = 0, limit:Int = 10, pmin: String = "10000", pmax: String = "100000", wholesale: Bool = true, official: Bool = true, fshop: Int = 2, callback : @escaping (APIResp) -> Void){
    
        let params: params = [
            "q" : "samsung",
            "pmin" : pmin,
            "pmax" : pmax,
            "wholesale" : wholesale,
            "official" : official,
            "fshop" : 2,
            "start" : offset,
            "rows" : limit
        ]
        
        APIHandler.request(url: "/search/v2.5/product", requestParam: params) { (APIResp) in
            callback(APIResp)
        }
    }
    
    
}
