//
//  PostServise.swift
//  MyToDo
//
//  Created by Pavel Spitcyn on 18.08.2021.
//

import UIKit
import Firebase

struct PostService {
    
    static let shared = PostService()
    let DB_REF = Database.database().reference()
    
    func fetchAllItems(completion: @escaping([TaskList]) -> Void) {
        
        var taskListArrayForReturn = [TaskList]()
        
        DB_REF.observe(.childAdded) { (snapshot) in
            let key = snapshot.key
            
            let taskList = TaskList()
            taskList.name = key
            
            let value = snapshot.value as! [String: Any]
            let keysArray = value.keys.sorted()
            
            for keyItem in keysArray {
                let task = Task()
                
                let valueItem = value[keyItem] as! [String: Any]
                
                task.task = valueItem["task"] as! String
                task.isCompleted = valueItem["isCompleted"] as! Bool
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let str = valueItem["notificationTime"] as! String
                let date = dateFormatter.date(from: str)
                task.notificationTime = date
                
                task.notificationIdentifier = valueItem["notificationIdentifier"] as! String
                
                taskList.taskArray.append(task)
            }
            
            taskListArrayForReturn.append(taskList)
            completion(taskListArrayForReturn)
        }
    }
    
    func uploadTaskListArray() {
        
        for taskList in TaskManager.shared().taskListArray {
            
            for task in taskList.taskArray {
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                
                var time = ""
                
                switch task.notificationTime {
                case nil:
                    time = ""
                default:
                    time = dateFormatter.string(from: task.notificationTime!)
                }
                
                let taskDictionary = ["task": task.task,
                                      "isCompleted": task.isCompleted,
                                      "notificationTime": time,
                                      "notificationIdentifier": task.notificationIdentifier] as [String: Any]
                
                let taskDict = ["\(task.task)": taskDictionary]
                DB_REF.child(taskList.name).updateChildValues(taskDict)
            }
        }
    }
    
    func removeData() {
        DB_REF.removeAllObservers()
        DB_REF.removeValue()
    }
}
