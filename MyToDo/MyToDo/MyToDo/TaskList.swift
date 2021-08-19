//
//  TaskList.swift
//  MyToDo
//
//  Created by Павел on 10.08.2021.
//

import Foundation

class TaskList {
    var taskArray = [Task]() {
        didSet {
            TaskManager.shared().saveData()
        }
    }
    var name = String()
}
