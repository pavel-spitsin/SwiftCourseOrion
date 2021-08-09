//
//  MasterCell.swift
//  MyToDo
//
//  Created by Pavel Spitcyn on 09.08.2021.
//

import UIKit

protocol MasterCellDelegate: AnyObject {
    func textChanged()
    func deleteEmptyRow(at indexPath: IndexPath)
}

class MasterCell: UITableViewCell, UITextViewDelegate {

    var indexPath = IndexPath()
    
    weak var delegate: MasterCellDelegate?
    
    @IBOutlet weak var checkmarkButton: UIButton!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectionStyle = .none
        
        textView.delegate = self
        
        checkmarkButton.layer.cornerRadius = checkmarkButton.bounds.height / 2
        checkmarkButton.layer.borderWidth = 2
        checkmarkButton.layer.borderColor = UIColor.gray.cgColor
        
        detailButton.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //MARK: - UITextViewDelegate

    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        detailButton.isHidden = false
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        delegate?.textChanged()
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        detailButton.isHidden = true
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        switch textView.text {
        case "":
            delegate?.deleteEmptyRow(at: indexPath)
        default:
            return
        }
        
    }
    
}
