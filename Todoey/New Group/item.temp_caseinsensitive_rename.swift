//
//  Item.swift
//  Todoey
//
//  Created by Tart Labs on 02/05/18.
//  Copyright © 2018 Tart Labs. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    var title:String = ""
    var done:Bool = false
}
