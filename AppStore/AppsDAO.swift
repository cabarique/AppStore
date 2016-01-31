//
//  AppsDAO.swift
//  AppStore
//
//  Created by luis cabarique on 1/31/16.
//  Copyright © 2016 cabarique inc. All rights reserved.
//

import Foundation
import RealmSwift

class AppsDAO: NSObject {
    func getAllApps() -> [AppModel]{
        let realm = try! Realm()
        let apps = realm.objects(AppModel)
        return Array(apps)
    }
}
