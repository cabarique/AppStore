//
//  AppsVO.swift
//  AppStore
//
//  Created by luis cabarique on 1/26/16.
//  Copyright © 2016 cabarique inc. All rights reserved.
//


import Foundation
import ObjectMapper

class AppsVO: Mappable {
    
    var apps: [AppModel] = []
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    func mapping(map: Map) {
        var entries: [AnyObject] = []; entries <- map["feed.entry"]
        for var index = 0; index <= entries.count; ++index {
            let app = AppModel()
            app.name <- map["feed.entry.\(index).im:name.label"]
            var images: [AnyObject] = []; images <- map["feed.entry.\(index).im:image"]
            for image in images{
                app.images.append(image["label"] as! String)
            }
            
            apps.append(app)
            
        }
    }
    
}
