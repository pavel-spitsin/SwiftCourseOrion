//
//  FirstViewController.swift
//  MyGallery
//
//  Created by Pavel Spitcyn on 04.08.2021.
//

import UIKit

class WelcomeViewController: UIViewController {

    var viewControllerIndex = Int()
    unowned var pageVC: PageViewController?
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var button: UIButton!
    
    @IBAction func buttonAction(_ sender: UIButton) {
        
        switch self {
        case pageVC?.vcs.last:
            pageVC?.dismiss(animated: true) {
                UserChecker.shared.setIsNotNewUser()
            }
        default:
            pageVC?.goToNextPage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        button.layer.cornerRadius = button.bounds.height / 2
        
        switch self {
        case pageVC?.vcs[0]:
            textView.text = "Welcome!"
            button.setTitle("Next", for: .normal)
        case pageVC?.vcs[1]:
            textView.text = "This is a test app for view your photo gallery"
            button.setTitle("Next", for: .normal)
        case pageVC?.vcs[2]:
            textView.text = "GO!"
            button.setTitle("Start", for: .normal)
        default:
            return
        }
    }
}
