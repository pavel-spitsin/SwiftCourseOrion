//
//  ViewController.swift
//  GCD-3(Async After, Concurrent Perform, Initially Inactive)
//
//  Created by Pavel Spitcyn on 24.06.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        afterBlock(seconds: 2, queue: .global()) {
            print("Hello")
            print(Thread.current)
        }
        */
        /*
        afterBlock(seconds: 2) {
            print("Hello")
            self.showAlert()
            print(Thread.current)
        }
        */
        
    }
    
    func showAlert() {
        let alert = UIAlertController(title: nil, message: "Hello", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func afterBlock(seconds: Int,
                    queue: DispatchQueue = DispatchQueue.main,
                    complition: @escaping ()->()) {
        queue.asyncAfter(deadline: .now() + .seconds(seconds)) {
            complition()
        }
    }
    
    

}

