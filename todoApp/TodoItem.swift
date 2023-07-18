//
//  TodoItem.swift
//  todoApp
//
//  Created by 呼元祐樹 on 2023/07/18.
//

import Foundation
import RealmSwift

class TodoItem: Object {
    @objc dynamic var id = ""
    @objc dynamic var title = ""
    @objc dynamic var date = Date()
}
