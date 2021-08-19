//
//  TaskManager.swift
//  MyToDo
//
//  Created by Pavel Spitcyn on 09.08.2021.
//

import Foundation

class TaskManager {

    var taskListArray = [TaskList]() {
        didSet {
            NotificationCenter.default.post(name: .DataDidFetched, object: nil)
            
            saveData()
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
        PostService.shared.fetchAllItems { taskList in
            self.taskListArray = taskList
            //PostService.shared.deleteData()
        }
    }
    
    func saveData() {
        deleteData()
        PostService.shared.uploadTaskListArray()
    }
    
    func deleteData() {
        PostService.shared.removeData()
    }
}

//MARK: - Notification extensions

extension Notification.Name {
    static let DataDidFetched = NSNotification.Name("DataDidFetched")
}
