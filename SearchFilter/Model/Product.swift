//
//  Product.swift
//  SearchFilter
//
//  Created by Muhammad Yaqub on 08/08/18.
//  Copyright © 2018 MiniProject. All rights reserved.
//

import Foundation
import ObjectMapper

class Product: Mappable{
    
    
    var id: Int?
    var name: String?
    var uri: String?
    var image_uri: String?
    var price: String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
        uri         <- map["uri"]
        image_uri   <- map["image_uri"]
        price       <- map["price"]
    }
}
