//
//  NotificationManager.swift
//  MyToDo
//
//  Created by Pavel Spitcyn on 16.08.2021.
//

import UIKit
import UserNotifications

class NotificationManager {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func notificationAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound]) {
            (permissionGranted, error) in
            if(!permissionGranted) {
                print("Permission Denied")
            }
        }
    }
    
    func createNotification(identifier: String, title: String, message: String, date: Date) {
        notificationCenter.getNotificationSettings { (settings) in
            DispatchQueue.main.async {

                if (settings.authorizationStatus == .authorized) {
                    let content = UNMutableNotificationContent()
                    content.title = title
                    content.body = message
                    content.sound = .default
                    
                    let dateComp = Calendar.current.dateComponents([.hour, .minute], from: date)
                    
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)
                    let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                    self.notificationCenter.add(request, withCompletionHandler: nil)
                }
            }
        }
    }
    
    func removeNotifications(withIdentifiers identifiers: [String]) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: identifiers)
    }
}
