//
//  Results+helper.swift
//  AppStore
//
//  Created by luis cabarique on 1/31/16.
//  Copyright © 2016 cabarique inc. All rights reserved.
//

import RealmSwift

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for var i = 0; i < count; i++ {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        
        return array
    }
}