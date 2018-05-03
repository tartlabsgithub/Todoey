//
//  Category.swift
//  Todoey
//
//  Created by Tart Labs on 02/05/18.
//  Copyright © 2018 Tart Labs. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name:String = ""
    let items = List<Item>()
}
