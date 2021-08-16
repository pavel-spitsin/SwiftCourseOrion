//
//  Task.swift
//  MyToDo
//
//  Created by Pavel Spitcyn on 09.08.2021.
//

import Foundation

class Task {
    var isCompleted: Bool = false
    var task = String()
    var notificationTime: Date? = nil
    var notificationIdentifier = String()
    
    init() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        notificationIdentifier = dateFormatter.string(from: Date())
    }
    
}
