//
//  ViewController.swift
//  MyCustomView
//
//  Created by Pavel Spitcyn on 09.06.2021.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var testView: TestView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        testView.mainLabel.text = "sup sup sup"
    }


}

