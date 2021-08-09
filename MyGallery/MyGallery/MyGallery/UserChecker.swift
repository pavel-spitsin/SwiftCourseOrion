//
//  UserChecker.swift
//  MyGallery
//
//  Created by Pavel Spitcyn on 04.08.2021.
//

import UIKit

class UserChecker {
    
    static let shared = UserChecker()
    
    func isNewUser() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func setIsNotNewUser() {
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
}
