//
//  CustomViewController.swift
//  MyNotifications
//
//  Created by Pavel Spitcyn on 02.06.2021.
//

import UIKit

class CustomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    let scores = ["Green": UIColor.green, "Red": UIColor.red]
    
    @IBAction func greenColor(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("green"), object: nil, userInfo: scores)
    }
    
    @IBAction func redColor(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("red"), object: nil, userInfo: scores)
    }
    
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
