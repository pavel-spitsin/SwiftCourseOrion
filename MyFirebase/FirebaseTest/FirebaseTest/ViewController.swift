//
//  ViewController.swift
//  FirebaseTest
//
//  Created by Pavel Spitcyn on 28.07.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func action1(_ sender: UIButton) {
        APIManager.shared.getPost(collection: "cars", docName: "smallCar") { doc in
            guard doc != nil else {return}
            self.label1.text = doc?.field1
            self.label2.text = doc?.field2
        }
        APIManager.shared.getImage(picName: "c-class", completion: {pic in
            self.picture.image = pic
        })
    }
    
    @IBAction func action2(_ sender: UIButton) {
        APIManager.shared.getPost(collection: "cars", docName: "middleCar") { doc in
            guard doc != nil else {return}
            self.label1.text = doc?.field1
            self.label2.text = doc?.field2
        }
        APIManager.shared.getImage(picName: "e-class", completion: {pic in
            self.picture.image = pic
        })
    }
    
    @IBAction func action3(_ sender: UIButton) {
        APIManager.shared.getPost(collection: "cars", docName: "bigCar") { doc in
            guard doc != nil else {return}
            self.label1.text = doc?.field1
            self.label2.text = doc?.field2
        }
        APIManager.shared.getImage(picName: "s-class", completion: {pic in
            self.picture.image = pic
        })
    }
    
    
    
}

