//
//  TimeTableViewCell.swift
//  MyToDo
//
//  Created by Pavel Spitcyn on 16.08.2021.
//

import UIKit

protocol TimeTableViewCellDelegate: AnyObject {
    func setTimeForNotification(time: Date)
}

class TimeTableViewCell: UITableViewCell {

    weak var timeDelegate: TimeTableViewCellDelegate?
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBAction func timePickerValueDidChanged(_ sender: UIDatePicker) {
        timeDelegate?.setTimeForNotification(time: timePicker.date)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        timeDelegate?.setTimeForNotification(time: timePicker.date)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
