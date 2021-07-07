//
//  RealmManager.swift
//  Homework14
//
//  Created by Bagrat Arutyunov on 07.07.2021.
//

import Foundation
import RealmSwift

protocol RealmManagerProtocol {
    func save(task: TaskR)
    func load() -> [TaskR]
    func remove(object: TaskR)
    func updateCompletion(object: TaskR)
}

class RealmManager: RealmManagerProtocol {
    
    
    fileprivate lazy var mainRealm = try! Realm(configuration: .defaultConfiguration)
    
    static let shared: RealmManager = RealmManager()
    
    func save(task: TaskR) {
        try! mainRealm.write {
            mainRealm.add(task)
        }
    }
    
    func load() -> [TaskR] {
        let tasks = try! mainRealm.objects(TaskR.self)
        return Array(tasks)
    }
    
    func remove(object: TaskR) {
        try! mainRealm.write {
            mainRealm.delete(object)
        }
    }
    
    func updateCompletion(object: TaskR) {
        try! mainRealm.write {
            object.isCompleted = !object.isCompleted
        }
    }

}
