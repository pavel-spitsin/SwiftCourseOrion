//
//  ViewController.swift
//  MyDelegation
//
//  Created by Pavel Spitcyn on 01.06.2021.
//

import UIKit

class ViewController: UIViewController, LogoDownloaderDelegate {
    
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    var logoDownloader: LogoDownloader?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        imageView.alpha = 0.0
        
        loginView.alpha = 0.0
        
        let imageURL: String = "https://cdn.spacetelescope.org/archives/images/publicationjpg/heic1509a.jpg"
        
        logoDownloader = LogoDownloader(logoURL: imageURL)
        
        logoDownloader?.delegate = self
        
        logoDownloader?.downloadLogo()
        
        if logoDownloader?.delegate == nil {
            loginView.alpha = 1.0
        }

    }
    
    func didFinishDownloading(_ sender: LogoDownloader) {
        imageView.image = logoDownloader?.image
        
        UIView.animate(withDuration: 2.0, delay: 0.5, options: UIView.AnimationOptions.curveEaseIn, animations:  {
                    self.loadingLabel.alpha = 0.0
                    self.imageView.alpha = 1.0
                }) { (completed:Bool) in
                    if (completed) {
                        UIView.animate(withDuration: 2.0) {
                            self.loginView.alpha = 1.0

                        }
                    }
            
        }
    }
}

