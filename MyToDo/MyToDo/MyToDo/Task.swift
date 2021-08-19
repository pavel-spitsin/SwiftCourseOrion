//
//  Task.swift
//  MyToDo
//
//  Created by Pavel Spitcyn on 09.08.2021.
//

import Foundation

class Task {
    var task = String() {
        didSet {
            TaskManager.shared().saveData()
        }
    }
    
    var isCompleted: Bool = false  {
        didSet {
            TaskManager.shared().saveData()
        }
    }
    
    var notificationTime: Date? = nil  {
        didSet {
            TaskManager.shared().saveData()
        }
    }
    
    var notificationIdentifier = String()  {
        didSet {
            TaskManager.shared().saveData()
        }
    }
    
    init() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        notificationIdentifier = dateFormatter.string(from: Date())
    }
    
}
