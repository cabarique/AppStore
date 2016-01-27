//
//  AppModel.swift
//  AppStore
//
//  Created by luis cabarique on 1/26/16.
//  Copyright © 2016 cabarique inc. All rights reserved.
//

import Foundation

class AppModel: NSObject {
    var name = ""
    var images: [String] = []
    var encondedImages: [NSData] = []
    var summary: String = ""
    var price: Double = 0.0
    var rights: String = ""
    var link: String = ""
    var categoriy: String = ""
    var releaseDate: NSDate = NSDate()
}
