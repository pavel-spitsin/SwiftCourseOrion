//
//  TaskManager.swift
//  MyToDo
//
//  Created by Pavel Spitcyn on 09.08.2021.
//

import Foundation

class TaskManager {
    
    var taskListArray = [TaskList]()
    
    //Singleton
    private static var uniqueInstance: TaskManager?
    private init() {}
    static func shared() -> TaskManager {
        if uniqueInstance == nil {
            uniqueInstance = TaskManager()
        }
        return uniqueInstance!
    }
}
