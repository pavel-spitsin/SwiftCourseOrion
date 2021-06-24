//
//  ViewController.swift
//  MyCoreDataLesson
//
//  Created by Pavel Spitcyn on 23.06.2021.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var dataStoreManager = DataStoreManager()
    
    @IBAction func removeDidPressed(_ sender: UIButton) {
        dataStoreManager.removeNameUser()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let user = dataStoreManager.obtainMainUser()
        nameLabel.text = user.name! + " " + (user.company?.name ?? "")
        ageLabel.text = String(user.age)
        
        nameLabel.sizeToFit()
        ageLabel.sizeToFit()
        
        textField.delegate = self
        
        textField.addTarget(self, action: #selector(textFieldDidChanched), for: .editingChanged)
    }
    
    @objc
    func textFieldDidChanched() {
        print("\(textField.text)")
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let name = textField.text else { return }
        dataStoreManager.updateMainUser(with: name)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

