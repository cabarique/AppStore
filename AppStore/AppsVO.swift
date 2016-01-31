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
    
    var apps: [[AppModel]] = []
    var categories: [String] = []
    
    required init?(_ map: Map) {
        //mapping(map)
    }
    
    func mapping(map: Map) {
        var entries: [AnyObject] = []; entries <- map["feed.entry"]
        for var i = 0; i < entries.count; i++ {
            let app = AppModel()
            app.name <- map["feed.entry.\(i).im:name.label"]
            app.summary <- map["feed.entry.\(i).summary.label"]
            app.category <- map["feed.entry.\(i).category.attributes.label"]
            app.artist <- map["feed.entry.\(i).im:artist.label"]
            app.link <- map["feed.entry.\(i).link.attributes.href"]
            if categories.contains(app.category) == false { categories.append(app.category) }
            var images: [AnyObject] = []; images <- map["feed.entry.\(i).im:image"]
            for image in images{
                app.images.append(image["label"] as! String)
            }
            let index = categories.indexOf(app.category)!
            if apps.count > index{
                apps[index].append(app)
            }else{
                apps.append([app])
            }
            
        }
    }
    
}
