//
//  TaskManager.swift
//  MyToDo
//
//  Created by Pavel Spitcyn on 09.08.2021.
//

import Foundation

class TaskManager {
    
    //Firebase
    var todoItems = [TodoItem]() {
        didSet {
            print("todo items was set")
        }
    }
    
    var taskListArray = [TaskList]() {
        didSet {
            NotificationCenter.default.post(name: Notification.Name.DataDidFetched, object: nil)
        }
    }
    
    //Singleton
    private static var uniqueInstance: TaskManager?
    private init() {}
    static func shared() -> TaskManager {
        if uniqueInstance == nil {
            uniqueInstance = TaskManager()
        }
        return uniqueInstance!
    }
    
    
    //MARK: - Data Actions
    
    func loadData() {
        PostService.shared.fetchAllItems { (allItems) in
            self.todoItems = allItems
        }
    }
    
    func saveData() {
        PostService.shared.uploadTaskListArray()
    }
    
    func deleteData() {
        PostService.shared.deleteData()
    }
}

//MARK: - Notification extensions

extension Notification.Name {
    static let DataDidFetched = NSNotification.Name("DataDidFetched")
}
