
//
//  AppStoreAPI.swift
//  AppStore
//
//  Created by luis cabarique on 1/26/16.
//  Copyright © 2016 cabarique inc. All rights reserved.
//

import Foundation
import Moya
import Alamofire

import ReactiveCocoa

// MARK: - Provider setup
let AppStoreAPI = ReactiveCocoaMoyaProvider<AppStoreEndPoints>() //Should be CustomReactiveCocoaMoyaProvider

// MARK: - Provider support

public enum AppStoreEndPoints {
    case getFreeApps(Int)
}


extension AppStoreEndPoints : TargetType {
    public var baseURL: NSURL { return NSURL(string: "https://itunes.apple.com")! }
    public var path: String {
        switch self {
            
        case .getFreeApps(let limit):
            return "/us/rss/topfreeapplications/limit=\(limit)/json"
        }
    }
    public var method: Moya.Method {
        return .GET
    }
    public var parameters: [String: AnyObject]? {
        switch self {
        default:
            return [:]
        }
    }
    
    public var sampleData: NSData {
        switch self {
        default:
            return "user status".dataUsingEncoding(NSUTF8StringEncoding)!
        }
    }
}


