//
//  ViewController.swift
//  MyLocalization(medium)
//
//  Created by Pavel Spitcyn on 12.07.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
    }

    @IBAction func press(_ sender: UIButton) {
        let alertTitle = NSLocalizedString("Welcome", comment: "")
        let alertMessage = NSLocalizedString("Thank you for trying this app, you are a great person!", comment: "")
        let cancelButtonText = NSLocalizedString("Cancel", comment: "")
        let signupButtonText = NSLocalizedString("Signup", comment: "")

        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: cancelButtonText, style: UIAlertAction.Style.cancel, handler: nil)
        let signupAction = UIAlertAction(title: signupButtonText, style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(signupAction)
        present(alert, animated: true, completion: nil)
    }

}

