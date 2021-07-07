//
//  CoreDataManager.swift
//  Homework14
//
//  Created by Bagrat Arutyunov on 07.07.2021.
//

import Foundation
import UIKit
import CoreData

protocol  CoreDataManagerProtocol {
    func save()
    func load() -> [Task]
    func remove(task: Task)
}

class CoreDataManager: CoreDataManagerProtocol {
    
    static let shared: CoreDataManager = CoreDataManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func save() {
        do {
            try context.save()
        } catch  {
            print("Error saving - \(error)")
        }
    }
    
    func load() -> [Task]{
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        guard let tasks = try? context.fetch(request) else {return []}
        return tasks
    }
    
    func remove(task: Task) {
        context.delete(task)
    }
    
}
