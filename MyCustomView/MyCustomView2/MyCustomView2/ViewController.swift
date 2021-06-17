//
//  ViewController.swift
//  MyCustomView2
//
//  Created by Pavel Spitcyn on 09.06.2021.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var smallButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var largeButton: UIButton!
    
    
    @IBOutlet weak var viewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewHeightConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        smallButton.layer.cornerRadius = smallButton.frame.height / 2
        mediumButton.layer.cornerRadius = mediumButton.frame.height / 2
        largeButton.layer.cornerRadius = largeButton.frame.height / 2
        
        smallButton.layer.borderWidth = 2
        mediumButton.layer.borderWidth = 2
        largeButton.layer.borderWidth = 2
        
        smallButton.layer.borderColor = UIColor.red.cgColor
        mediumButton.layer.borderColor = UIColor.red.cgColor
        largeButton.layer.borderColor = UIColor.red.cgColor
        
        contentView.layer.cornerRadius = 20
        
        contentView.clipsToBounds = true
        
        let smallView = SmallCardView(frame: contentView.bounds)
        
        contentView.addSubview(smallView)
    }


    //MARK: - Button actions
    
    @IBAction func smallButtonAction(_ sender: UIButton) {

        let _ = contentView.subviews[0].removeFromSuperview()
        contentView.addSubview(SmallCardView(frame: contentView.bounds))
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            
            self.viewWidthConstraint.constant = 200
            self.viewHeightConstraint.constant = 200
            self.view.layoutIfNeeded()
            
            
            self.contentView.subviews[0].frame = self.contentView.bounds
        })
    }
    
    @IBAction func mediumButtonAction(_ sender: UIButton) {

        let _ = contentView.subviews[0].removeFromSuperview()
        contentView.addSubview(MediumCardView(frame: contentView.bounds))

        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: { [self] in

            self.viewWidthConstraint.constant = 300
            self.viewHeightConstraint.constant = 240
            self.view.layoutIfNeeded()
            
            
            self.contentView.subviews[0].frame = self.contentView.bounds
        })
        
    }
    
    @IBAction func largeButtonAction(_ sender: UIButton) {

        let _ = contentView.subviews[0].removeFromSuperview()
        contentView.addSubview(LargeCardView(frame: contentView.bounds))
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            self.viewWidthConstraint.constant = 400
            self.viewHeightConstraint.constant = 400
            self.view.layoutIfNeeded()
            self.contentView.subviews[0].frame = self.contentView.bounds
        })
        
    }
    
}

