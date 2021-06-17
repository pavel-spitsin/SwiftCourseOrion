//
//  SoundsViewController.swift
//  MyTableView
//
//  Created by Pavel Spitcyn on 04.06.2021.
//

import UIKit
import AVFoundation

class SoundsViewController: UIViewController {

    var systemSoundID: SystemSoundID = 1000

    @IBOutlet weak var idLabel: UILabel!
    
    
    @IBAction func previous(_ sender: UIButton) {

        //AudioServicesDisposeSystemSoundID(<#T##inSystemSoundID: SystemSoundID##SystemSoundID#>)
        
        switch systemSoundID {
        case 1000:
            systemSoundID = 1000
        default:
            systemSoundID -= 1
        }
        idLabel.text = "\(systemSoundID)"
        AudioServicesPlaySystemSound(systemSoundID)
    }
    
    @IBAction func next(_ sender: UIButton) {
        systemSoundID += 1
        idLabel.text = "\(systemSoundID)"
        AudioServicesPlaySystemSound(systemSoundID)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
