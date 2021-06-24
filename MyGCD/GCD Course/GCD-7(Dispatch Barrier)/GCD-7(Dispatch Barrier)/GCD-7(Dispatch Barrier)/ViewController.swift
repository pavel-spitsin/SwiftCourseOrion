//
//  ViewController.swift
//  GCD-7(Dispatch Barrier)
//
//  Created by Pavel Spitcyn on 24.06.2021.
//

import UIKit

class ViewController: UIViewController {

    var array = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        for i in 0...9 {
            array.append(i)
        }
        
        print(array)
        print(array.count)
        */
        
        /*
        DispatchQueue.concurrentPerform(iterations: 10) { (index) in
            array.append(index)
        }
        
        print(array)
        print(array.count)
        */
        
        let arraySafe = SafeArray<Int>()
        DispatchQueue.concurrentPerform(iterations: 10) { (index) in
            arraySafe.append(index)
            print(Thread.current, "index = \(index)")
        }
        
        //print("arraySafe", arraySafe.valueArray)
    }
}


class SafeArray<T> {
    private var array = [T]()
    private let queue = DispatchQueue(label: "The Swift Developers", attributes: .concurrent)
    
    public func append(_ value: T) {
        queue.async(flags: .barrier) {
            self.array.append(value)
            print(Thread.current, "value = \(value)")
        }
    }
    
    public var valueArray: [T] {
        var result = [T]()
        queue.sync {
            result = self.array
        }
        return result
    }
}
