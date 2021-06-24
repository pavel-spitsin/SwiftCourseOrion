//
//  ViewController.swift
//  GCD-4(DispatchWorkItem, notify)
//
//  Created by Pavel Spitcyn on 24.06.2021.
//

import UIKit

class ViewController: UIViewController {

    let imageURL = URL(string: "https://images.wallpaperscraft.ru/image/para_zvezdnoe_nebo_art_123338_3000x3000.jpg")
    
    
    let someImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))

    override func viewDidLoad() {
        super.viewDidLoad()

        /*
        let dispatchWorkItem1 = DispatchWorkItem1()
        dispatchWorkItem1.create()
        */
        
        /*
        let dispatchWorkItem2 = DispatchWorkItem2()
        dispatchWorkItem2.create()
        */
        
        someImage.backgroundColor = .yellow
        someImage.contentMode = .scaleAspectFill
        view.addSubview(someImage)
        
        //fetchImage()
        fetchImage2()
    }
    
    //#1 classic
    func fetchImage() {

        let queue = DispatchQueue.global(qos: .utility)
        
        queue.async {
            if let data = try? Data(contentsOf: self.imageURL!)
            {
                DispatchQueue.main.async {
                    self.someImage.image = UIImage(data: data)
                }
            }
        }
    }
    
    //#2 Dispatch work item
    func fetchImage2() {
        var data: Data?
        let queue = DispatchQueue.global(qos: .utility)
        
        let workItem = DispatchWorkItem(qos: .userInteractive) { [self] in
            data = try? Data(contentsOf: self.imageURL!)
            print(Thread.current)
        }
        
        queue.async(execute: workItem)
        
        workItem.notify(queue: DispatchQueue.main) {
            if let imageData = data {
                self.someImage.image = UIImage(data: imageData)
            }
        }
    }
    
    //#3 URLSession
    func fetchImage3() {
        let task = URLSession.shared.dataTask(with: imageURL!) { data, responce, error in
            print(Thread.current)
            if let imageData = data {
                DispatchQueue.main.async {
                    print(Thread.current)
                    self.someImage.image = UIImage(data: imageData)
                }
            }
        }
        task.resume()
    }
    
    
}


class DispatchWorkItem1 {
    private let queue = DispatchQueue(label: "DispatchWorkItem1", attributes: .concurrent)
    
    func create() {
        let workItem = DispatchWorkItem {
            print(Thread.current)
            print("Start task")
        }
        
        workItem.notify(queue: .main) {
            print(Thread.current)
            print("Task finish")
        }
        
        queue.async(execute: workItem)
    }
}

class DispatchWorkItem2 {
    private let queue = DispatchQueue(label: "DispatchWorkItem1") //без атрибута - по умолчанию serial
    
    func create() {
        queue.async {
            sleep(1)
            print(Thread.current)
            print("Task 1")
        }
        
        queue.async {
            sleep(1)
            print(Thread.current)
            print("Task 2")
        }
        
        let workItem = DispatchWorkItem {
            print(Thread.current)
            print("Start work item task")
        }
        
        queue.async(execute: workItem)
        
        workItem.cancel() //отменить work item. Отменять задачу можно тогда, когда она еще не начала выполняться.
    }
}


