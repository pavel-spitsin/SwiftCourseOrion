//
//  PostServise.swift
//  MyToDo
//
//  Created by Pavel Spitcyn on 18.08.2021.
//

import UIKit
import Firebase

struct TodoItem {
    var title: String
    var isComplete: Bool
    //var id: Int
    
    init(keyID: String, dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.isComplete = dictionary["isComplete"] as? Bool ?? false
    }
}

struct PostService {
    
    static let shared = PostService()
    let DB_REF = Database.database().reference()
    
    func fetchAllItems(completion: @escaping([TodoItem]) -> Void) {
        
        var allItems = [TodoItem]()
        
        DB_REF.child("items").observe(.childAdded) { (snapshot) in
            fetchSingleItem(id: snapshot.key) { (item) in
                allItems.append(item)
                completion(allItems)
            }
        }
    }
    
    func fetchSingleItem(id: String, completion: @escaping(TodoItem) -> Void) {
        DB_REF.child("items").child(id).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            let todoItem = TodoItem(keyID: id, dictionary: dictionary)
            completion(todoItem)
        }
    }
    
    /*
    func uploadTodoItem(text: String) {
        let values = ["title": text, "isComplete": false] as [String: Any]
        DB_REF.child("items").childByAutoId().updateChildValues(values)
    }*/
    /*
    func uploadTodoItem(text: String) {
        let value = ["text": text] as [String: String]
        DB_REF.child("mytodo-e5e96-default-rtdb").childByAutoId().updateChildValues(value)
    }*/
    
    
    func uploadTaskListArray() {
        /*
        let taskListArray = ["TaskListArray": "taskListArray"] as [String: String]
        //DB_REF.updateChildValues(taskListArray)
        DB_REF.child("Data").updateChildValues(taskListArray)
        */
        

        for taskList in TaskManager.shared().taskListArray {
            /*
            let value = [taskList.name: taskList.name]
            DB_REF.child("TaskListArray").updateChildValues(value)
            */
            var i = 0
            for taskInTasklist in taskList.taskArray {
                let taskName = ["Task" + String(i): taskInTasklist.task]
                DB_REF.child("TaskListArray").child(taskList.name).updateChildValues(taskName)

                
                let task = ["task" + String(i): taskInTasklist.task]
                //DB_REF.child("TaskListArray").child(taskList.name).child(taskInTasklist.task).updateChildValues(task)
                DB_REF.child(taskList.name).child(taskInTasklist.task).updateChildValues(task)
                

                i = i + 1
            }
            
            /*
            var i = 0
            for taskInTasklist in taskList.taskArray {
                i += 1
                let prop = [[taskInTasklist.task: taskInTasklist.task]: "Task"]
                DB_REF.child("TaskListArray").child(taskList.name).child(taskInTasklist.task).updateChildValues(prop)
            }
            */
            /*
            var i = 0
            
            for taskInTasklist in taskList.taskArray {

                i += 1
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                
                var dateString = String()
                
                switch taskInTasklist.notificationTime {
                case nil:
                    dateString = "nil"
                default:
                    dateString = dateFormatter.string(from: taskInTasklist.notificationTime!)
                }
                
                let values = ["isCompleted" + String(i): taskInTasklist.isCompleted,
                              "task" + String(i): taskInTasklist.task,
                              "notificationTime" + String(i): dateString,
                              "notificationIdentifier" + String(i): taskInTasklist.notificationIdentifier] as [String: Any]
                DB_REF.child(taskList.name).updateChildValues(values)
                
                /*
                let task = ["Task": taskInTasklist.task]
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                let notificationTime = ["Notification Time": dateFormatter.string(from: taskInTasklist.notificationTime!)]
                
                let notificationIdentifier = ["Notification Identifier": taskInTasklist.notificationIdentifier]
                */
                
            }*/
        }
    }
    
    func deleteData() {
        DB_REF.removeValue()
        //DB_REF.child("TaskListArray").childByAutoId().removeValue()
    }
    
    
    //Test
    
    
    
    
}
