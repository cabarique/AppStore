//
//  AppStoreClient.swift
//  AppStore
//
//  Created by luis cabarique on 1/26/16.
//  Copyright © 2016 cabarique inc. All rights reserved.
//

import Foundation
import ReactiveCocoa

@objc public protocol AppStoreClient {
    
    func getFreeApps(withLimit limit: Int) -> RACSignal
    
}