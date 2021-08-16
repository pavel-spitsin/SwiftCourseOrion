//
//  SettingsTableViewCell.swift
//  MyToDo
//
//  Created by Pavel Spitcyn on 16.08.2021.
//

import UIKit

protocol SwitchSelectionDelegate: AnyObject {
    func switchSelectedPosition(position: Bool)
}

class SettingsTableViewCell: UITableViewCell {

    weak var switchDelegate: SwitchSelectionDelegate?
    
    @IBOutlet weak var timeIconImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeSwitch: UISwitch!
    
    @IBAction func switchAction(_ sender: UISwitch) {
        switchDelegate?.switchSelectedPosition(position: timeSwitch.isOn)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        timeIconImageView.layer.cornerRadius = 6
        timeLabel.text = "Время"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
