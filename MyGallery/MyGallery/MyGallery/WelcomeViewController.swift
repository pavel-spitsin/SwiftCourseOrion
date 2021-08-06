//
//  FirstViewController.swift
//  MyGallery
//
//  Created by Pavel Spitcyn on 04.08.2021.
//

import UIKit

protocol WelcomeViewControllerDelegate: AnyObject {
    func goNextPressed(index: Int)
    func textAndButtonTitle(for viewController: WelcomeViewController)
}

class WelcomeViewController: UIViewController {
    
    weak var delegate: WelcomeViewControllerDelegate?
    var viewControllerIndex = Int()

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var button: UIButton!
    
    @IBAction func buttonAction(_ sender: UIButton) {
        delegate?.goNextPressed(index: viewControllerIndex)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.layer.cornerRadius = button.bounds.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        delegate?.textAndButtonTitle(for: self)
    }
    
}
