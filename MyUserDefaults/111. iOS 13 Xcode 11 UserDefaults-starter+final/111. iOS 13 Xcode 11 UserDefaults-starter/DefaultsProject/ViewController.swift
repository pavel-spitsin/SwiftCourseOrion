//
//  ViewController.swift
//  DefaultsProject
//
//  Created by Алексей Пархоменко on 17.03.2020.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit

enum SexType: String {
    case male
    case female
}

class UserModel: NSObject, NSCoding {

    let name: String
    let surname: String
    let city: String
    let sex: SexType
    
    init(name: String, surname: String, city: String, sex: SexType) {
        self.name = name
        self.surname = surname
        self.city = city
        self.sex = sex
    }
    
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(surname, forKey: "surname")
        coder.encode(city, forKey: "city")
        coder.encode(sex.rawValue, forKey: "sex")
    }
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String ?? ""
        surname = coder.decodeObject(forKey: "surname") as? String ?? ""
        city = coder.decodeObject(forKey: "city") as? String ?? ""
        sex = SexType(rawValue: coder.decodeObject(forKey: "sex") as! String) ?? SexType.male
    }
    
}

class ViewController: UIViewController {
    
    let cities = ["Mountain View", "Sunnyvale", "Cupertino", "Santa Clara", "San Jose"]
    let sexArray = ["Мужской", "Женский"]
    var pickedCity: String?
    var pickedSex: SexType?

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var cityPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.delegate = self
        
        cityPickerView.delegate = self
        cityPickerView.dataSource = self
 
        name.text = UserSettings.userName
        surname.text = UserSettings.userSurname

    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            pickedSex = .male
        case 1:
            pickedSex = .female
        default:
            break
        }
        
        let nameTrimmingText = name.text!.trimmingCharacters(in: .whitespaces)
        let surnameTrimmingText = surname.text!.trimmingCharacters(in: .whitespaces)
        let ccc = cities[cityPickerView.selectedRow(inComponent: 0)]
        print("\(cityPickerView.selectedRow(inComponent: 0)) selected")
        
       //guard let pickedCity = pickedCity, let pickedSex = pickedSex else { return }
        let userObject = UserModel(name: nameTrimmingText,
                                   surname: surnameTrimmingText,
                                   city: ccc,
                                   sex: pickedSex!)
        
        //UserSettings.userModel = userObject
        UserSettings.userName = userObject.name
        UserSettings.userSurname = userObject.surname
        
        UserDefaults.standard.synchronize()
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let city = cities[row]
        return city
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedCity = cities[row]
    }

    
}
