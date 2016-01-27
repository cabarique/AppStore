//
//  AppStoreClientImp.swift
//  AppStore
//
//  Created by luis cabarique on 1/26/16.
//  Copyright © 2016 cabarique inc. All rights reserved.
//

import Foundation
import Moya
import ReactiveCocoa
import ObjectMapper

public class AppStoreClientImp: NSObject, AppStoreClient {
    static let sharedInstance = AppStoreClientImp()
    
    public func getFreeApps(withLimit limit: Int) -> RACSignal{
        let signal = RACSignal.createSignal { (subscriber) -> RACDisposable! in
            
            AppStoreAPI.request(.getFreeApps(limit)).filterSuccessfulStatusCodes().mapJSON().subscribeNext({ (response) -> Void in
                subscriber.sendNext(Mapper<AppsVO>().map(response))
                

                }, error: { (error) -> Void in
                    subscriber.sendError(error)
                    subscriber.sendCompleted()
            })
            return nil
        }
        
        return signal

    }
}
