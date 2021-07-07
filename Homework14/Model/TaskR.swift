//
//  TaskR.swift
//  Homework14
//
//  Created by Bagrat Arutyunov on 07.07.2021.
//

import Foundation
import RealmSwift

class TaskR: Object {
    @objc dynamic var task: String = ""
    @objc dynamic var isCompleted = false
}
