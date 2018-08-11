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
import SystemConfiguration

typealias params = Parameters
let baseURL: String = "https://ace.tokopedia.com"

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
    
    enum ReachabilityStatus {
        case notReachable
        case reachableViaWWAN
        case reachableViaWiFi
    }

    
    class func getcurrentReachabilityStatus() -> ReachabilityStatus{
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return .notReachable
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return .notReachable
        }
        
        if flags.contains(.reachable) == false {
            // The target host is not reachable.
            return .notReachable
        }
        else if flags.contains(.isWWAN) == true {
            // WWAN connections are OK if the calling application is using the CFNetwork APIs.
            return .reachableViaWWAN
        }
        else if flags.contains(.connectionRequired) == false {
            // If the target host is reachable and no connection is required then we'll assume that you're on Wi-Fi...
            return .reachableViaWiFi
        }
        else if (flags.contains(.connectionOnDemand) == true || flags.contains(.connectionOnTraffic) == true) && flags.contains(.interventionRequired) == false {
            // The connection is on-demand (or on-traffic) if the calling application is using the CFSocketStream or higher APIs and no [user] intervention is needed
            return .reachableViaWiFi
        }
        else {
            return .notReachable
        }
    }
    
    class func request(url : String, overrideUrl : Bool? = false, requestMethod method : HTTPMethod = .get, requestParam parameter : Parameters? = nil, checkConnection : Bool = true, requestEncoding encoding : ParameterEncoding = URLEncoding.default, requestHeaders headers : [String:String]? = nil, callback : @escaping (APIResp) -> Void){
        
        if checkConnection {
            if getcurrentReachabilityStatus() == .notReachable {
                
                LoadingOverlay.shared.hideOverlay()
                
                print("No Internet Connection")
                return
            }
        }
        let aUrl = "\(baseURL)\(url)"
        
        Alamofire.request(aUrl, method: .get, parameters: parameter).responseObject { (response : DataResponse<APIResp>) in
            switch response.result{
            case .success(let apiResp):
                callback(apiResp)
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
        
    }
    
    func getProduct(offset:Int = 0, limit:Int = 10, pmin: String = "10000", pmax: String = "100000", wholesale: Bool = true, official: Bool = true, fshop: Int = 2, callback : @escaping (APIResp) -> Void){
        
        let params: Parameters = [
            "q" : "samsung",
            "pmin" : pmin,
            "pmax" : pmax,
            "wholesale" : wholesale,
            "official" : official,
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
