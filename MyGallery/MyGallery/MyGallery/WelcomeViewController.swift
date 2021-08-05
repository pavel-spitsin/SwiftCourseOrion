//
//  FirstViewController.swift
//  MyGallery
//
//  Created by Pavel Spitcyn on 04.08.2021.
//

import UIKit

class WelcomeViewController: UIViewController {

    var viewControllerIndex = Int()

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var button: UIButton!
    
    @IBAction func buttonAction(_ sender: UIButton) {
        
        guard let parentPageViewController = self.parent as? PageViewController else {return}
        
        switch self {
        case parentPageViewController.viewControllersArray.last:
            parentPageViewController.dismiss(animated: true) {
                UserChecker.shared.setIsNotNewUser()
            }
        default:
            parentPageViewController.goToNextPage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        button.layer.cornerRadius = button.bounds.height / 2
        
        guard let vc = self.parent as? PageViewController else {return}

        switch self {
        case vc.viewControllersArray[0]:
            textView.text = NSLocalizedString("1st_welcome_screen_label_text", comment: "")
            button.setTitle(NSLocalizedString("1st_welcome_screen_button_text", comment: ""), for: .normal)
        case vc.viewControllersArray[1]:
            textView.text = NSLocalizedString("2nd_welcome_screen_label_text", comment: "")
            button.setTitle(NSLocalizedString("2nd_welcome_screen_button_text", comment: ""), for: .normal)
        case vc.viewControllersArray[2]:
            textView.text = NSLocalizedString("3rd_welcome_screen_label_text", comment: "")
            button.setTitle(NSLocalizedString("3rd_welcome_screen_button_text", comment: ""), for: .normal)
        default:
            return
        }
    }
}
