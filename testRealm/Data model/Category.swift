//
//  Category.swift
//  testRealm
//
//  Created by Mac on 9/16/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
    let array = [Int]()
}
