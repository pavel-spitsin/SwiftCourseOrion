//
//  NavigationController.swift
//  MyGallery
//
//  Created by Павел on 05.08.2021.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = NSLocalizedString("navigationBar_title_text", comment: "")
    }
}
