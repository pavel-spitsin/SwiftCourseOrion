//
//  ViewController.swift
//  GCD-5(Semaphore)
//
//  Created by Pavel Spitcyn on 24.06.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Вариант1
        /*
        let queue = DispatchQueue(label: "The Swift Developer",
                                  attributes: .concurrent)
        
        let semaphore = DispatchSemaphore(value: 1)
        
        queue.async {
            semaphore.wait() //-1
            sleep(3)
            print("method 1")
            semaphore.signal() // + 1
        }
        
        queue.async {
            semaphore.wait() //-1
            sleep(3)
            print("method 2")
            semaphore.signal() // + 1
        }
        
        queue.async {
            semaphore.wait() //-1
            sleep(3)
            print("method 3")
            semaphore.signal() // + 1
        }
        */
        
        //Вариант2
        /*
        let sem = DispatchSemaphore(value: 2)
        
        DispatchQueue.concurrentPerform(iterations: 10) { (id: Int) in
            sem.wait(timeout: DispatchTime.distantFuture)
            sleep(1)
            print("Block", String(id))
            
            sem.signal()
        }
        */
        
        
        let semaphoreTest = SemaphoreTest()
        semaphoreTest.startAllThread()
    }
}

//Вариант3
class SemaphoreTest {
    private let semaphore = DispatchSemaphore(value: 2)
    private var array = [Int]()
    
    func methodWork(_ id: Int) {
        semaphore.wait()
        
        array.append(id)
        print("test array", array.count)
        
        Thread.sleep(forTimeInterval: 1)
        semaphore.signal()
    }
    
    func startAllThread() {
        DispatchQueue.global().async {
            self.methodWork(111)
            //print(Thread.current)
        }
        DispatchQueue.global().async {
            self.methodWork(222)
            //print(Thread.current)
        }
        DispatchQueue.global().async {
            self.methodWork(333)
            //print(Thread.current)
        }
        DispatchQueue.global().async {
            self.methodWork(444)
            //print(Thread.current)
        }
        DispatchQueue.global().async {
            self.methodWork(555)
            //print(Thread.current)
        }
    }
}



