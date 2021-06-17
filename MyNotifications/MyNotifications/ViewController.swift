//
//  ViewController.swift
//  MyNotifications
//
//  Created by Pavel Spitcyn on 02.06.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var customView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        NotificationCenter.default.addObserver(self, selector: #selector(makeItGreen), name: .greenName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(makeItRed), name: .redName, object: nil)
    }

//MARK: Functions
    
    @objc
    func makeItGreen(_ notification: Notification) {
        if let data = notification.userInfo as? [String: UIColor] {
            customView.backgroundColor = data["Green"]
        }
    }
    
    @objc
    func makeItRed(_ notification: Notification) {
        if let data = notification.userInfo as? [String: UIColor] {
            customView.backgroundColor = data["Red"]
        }
    }
}

//MARK: Notification extension

extension Notification.Name {
    static let greenName = NSNotification.Name("green")
    static let redName = NSNotification.Name("red")
}
