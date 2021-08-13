//
//  MasterCell.swift
//  MyToDo
//
//  Created by Павел on 10.08.2021.
//

import UIKit

class MasterCell: UITableViewCell {

    var indicatorLine: UIView?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func addUpperIndicator() {
        indicatorLine = UIView()
        indicatorLine?.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 2)
        indicatorLine?.backgroundColor = UIColor.systemBlue
        self.contentView.addSubview(indicatorLine!)
    }
    
    func addLowerIndicator() {
        indicatorLine = UIView()
        indicatorLine?.frame = CGRect(x: 0, y: self.bounds.height, width: self.bounds.width, height: -2)
        indicatorLine?.backgroundColor = UIColor.systemBlue
        self.contentView.addSubview(indicatorLine!)
    }

    func removeIndicator() {
        
        guard indicatorLine != nil else {
            return
        }
        indicatorLine?.removeFromSuperview()
    }
}
