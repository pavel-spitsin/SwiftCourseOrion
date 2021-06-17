//
//  MyNotificationClass.swift
//  MyNotifications
//
//  Created by Pavel Spitcyn on 02.06.2021.
//

import UIKit

class MyNotificationClass: NSObject {

}

class URLContainer {
    private(set) var urls: [URL] = []
    
    //Post notification
    func add(_ url: URL) {
        urls.append(url)
        NotificationCenter.default.post(name: .URLContainerDidAddURL, object: self, userInfo: [URLContainer.urlKey: url])
    }
    
    static let urlKey = "URL"
}

extension Notification.Name {
    static let URLContainerDidAddURL = NSNotification.Name("URLContainerDidAddURL")
}

class Controller {
    
    //Add observer
    func subscribe(for container: URLContainer) {
            NotificationCenter.default.addObserver(self,
                selector: #selector(urlContainerDidAddURL(_:)),
                name: .URLContainerDidAddURL,
                object: container)
        }
    
    @objc
    func urlContainerDidAddURL(_ notification: Notification) {
        let url = notification.userInfo?[URLContainer.urlKey]
        print(url!)
    }
    
    //Remove observer
    func unsubscribe(from container: URLContainer) {
        NotificationCenter.default.removeObserver(self, name: .URLContainerDidAddURL, object: container)
    }
    
    
    //Observing Notification using Closure
    private var observer: AnyObject?
    
    func subscribe1(for container: URLContainer) {
        guard observer == nil else { return }
        observer = NotificationCenter.default.addObserver(forName: .URLContainerDidAddURL, object: container, queue: nil) { notification in
            let url = notification.userInfo?[URLContainer.urlKey]
            print(url!)
        }
    }
    
    func unsubscribe() {
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer)
            self.observer = nil
        }
    }
    
    deinit {
        unsubscribe()
    }

}

