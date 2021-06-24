//
//  UserSettings.swift
//  DefaultsProject
//
//  Created by Алексей Пархоменко on 17.03.2020.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import Foundation

final class UserSettings {
    
    private enum SettingsKeys: String {
        case username
        case userSurname
        case userCity
        case usermodel
    }
    
    static var userModel: UserModel! {
        get {
            guard let savedData = UserDefaults.standard.object(forKey: SettingsKeys.usermodel.rawValue) as? Data, let decodeModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? UserModel else { return nil }
            return decodeModel
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.usermodel.rawValue
            
            if let userModel = newValue {
                if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: userModel, requiringSecureCoding: false) {
                    defaults.set(savedData, forKey: key)
                }
            }
        }
    }
  
    static var userName: String! {
        get {
            return UserDefaults.standard.string(forKey: SettingsKeys.username.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.username.rawValue
            if let name = newValue {
                print("value \(name) was added to key \(key)")
                defaults.setValue(name, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var userSurname: String! {
        get {
            return UserDefaults.standard.string(forKey: SettingsKeys.userSurname.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.userSurname.rawValue
            if let surname = newValue {
                print("value \(surname) was added to key \(key)")
                defaults.setValue(surname, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
 
}
