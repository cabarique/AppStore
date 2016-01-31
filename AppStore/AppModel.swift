//
//  AppModel.swift
//  AppStore
//
//  Created by luis cabarique on 1/26/16.
//  Copyright © 2016 cabarique inc. All rights reserved.
//

import Foundation
import RealmSwift

class AppModel: Object {
    dynamic var name = ""
    dynamic var artist = ""
    dynamic var image: String = ""
    dynamic var encodedImage: NSData?
    dynamic var summary: String = ""
    dynamic var price: Double = 0.0
    dynamic var rights: String = ""
    dynamic var link: String = ""
    dynamic var category: String = ""
    dynamic var releaseDate: NSDate = NSDate()
}
