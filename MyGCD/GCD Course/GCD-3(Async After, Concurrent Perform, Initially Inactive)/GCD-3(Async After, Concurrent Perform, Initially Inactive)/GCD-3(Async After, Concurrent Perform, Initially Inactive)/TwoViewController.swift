//
//  TwoViewController.swift
//  GCD-3(Async After, Concurrent Perform, Initially Inactive)
//
//  Created by Pavel Spitcyn on 24.06.2021.
//

import UIKit

class TwoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /*
        for i in 0...200000 {
            print(i)
        }
        */

        /*
        //concurrentPerform - вместо циклов
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            DispatchQueue.concurrentPerform(iterations: 200000) {
                print("\($0) times")
                print(Thread.current)
                
            }
        }
        */
        
        myInactiveQueue()
        
    }
    
    func myInactiveQueue() {
        let inactiveQueue = DispatchQueue(label: "The Swift Dev", attributes: [.concurrent, .initiallyInactive])
        
        inactiveQueue.async {
            print("Done!")
        }
        print("Not yet started...")
        inactiveQueue.activate() //очередь активна
        print("Activate!")
        inactiveQueue.suspend() // очередь легла поспать
        print("Pause!")
        inactiveQueue.resume()
    }
    
}
