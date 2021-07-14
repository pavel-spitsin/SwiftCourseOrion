//
//  ViewController.swift
//  MyBiometricAuthentification
//
//  Created by Pavel Spitcyn on 12.07.2021.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //deviceOwnerAuthenticationWithBiometrics
    @IBAction func action(_ sender: Any) {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            
            let reason = "Please authoreze with touch id!"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) {[weak self] success, error in
                
                DispatchQueue.main.async {
                    guard success, error == nil else {
                        
                        //failed
                        let alert = UIAlertController(title: "Failed to Authentificate", message: "Please try again.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                        self?.present(alert, animated: true)

                        return
                    }
                    
                    //Show other screen
                    //Success
                    let vc = UIViewController()
                    vc.title = "Welcome!"
                    vc.view.backgroundColor = .systemBlue
                    
                    let nvc = UINavigationController(rootViewController: vc)
                    //nvc.modalPresentationStyle = .fullScreen
                    
                    self?.present(nvc, animated: true, completion: nil)
                }
            }
        } else {
            // Can not use
            let alert = UIAlertController(title: "Unavailable", message: "You can't use this feature", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    }

}











