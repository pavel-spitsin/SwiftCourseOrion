//
//  MasterCell.swift
//  MyToDo
//
//  Created by Pavel Spitcyn on 09.08.2021.
//

import UIKit

protocol DetailCellDelegate: AnyObject {
    func textChangedInCell(cell: DetailCell)
    func deleteRow(at rowIndex: Int)
    func showSettingsViewController(viewController: UIViewController)
    func returnTaskList() -> TaskList
}

class DetailCell: UITableViewCell {

    var indexPath = IndexPath()
    let checkmarkColor: CGColor = UIColor.lightGray.cgColor
    
    weak var delegate: DetailCellDelegate?
    
    @IBOutlet weak var checkmarkButton: UIButton!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func checkmarkAction(_ sender: UIButton) {
        
        switch delegate?.returnTaskList().taskArray[indexPath.row].isCompleted {
        case true:
            isCheckmarkActive(active: false)
            delegate?.returnTaskList().taskArray[indexPath.row].isCompleted = false
        default:
            isCheckmarkActive(active: true)
            delegate?.returnTaskList().taskArray[indexPath.row].isCompleted = true
        }
    }
    
    @IBAction func detailButtonAction(_ sender: UIButton) {
        guard textView.text != "" else { return }
        let settingsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        settingsViewController.navigationItem.title = "Напоминание"
        settingsViewController.task = (delegate?.returnTaskList().taskArray[indexPath.row])!
        delegate?.showSettingsViewController(viewController: settingsViewController)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
                
        textView.delegate = self
        
        checkmarkButton.layer.cornerRadius = checkmarkButton.bounds.height / 2
        checkmarkButton.layer.borderWidth = 1.5
        checkmarkButton.layer.borderColor = UIColor.lightGray.cgColor
        
        detailButton.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    //MARK: - Functions
    
    func isCheckmarkActive(active: Bool) {
        
        switch active {
        case true:
            checkmarkButton.backgroundColor = UIColor.systemGreen
            checkmarkButton.layer.borderColor = UIColor.systemGreen.cgColor
            
            checkmarkButton.setImage(UIImage.init(systemName: "checkmark"), for: .normal)
            textView.textColor = UIColor.lightGray
        case false:
            checkmarkButton.backgroundColor = UIColor.clear
            checkmarkButton.layer.borderColor = UIColor.lightGray.cgColor
            textView.textColor = UIColor.black
        }
    }
}


//MARK: - UITextViewDelegate

extension DetailCell: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        detailButton.isHidden = false
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        delegate?.textChangedInCell(cell: self)
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        detailButton.isHidden = true
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        switch textView.text {
        case "":
            delegate?.deleteRow(at: indexPath.row)
        default:
            return
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
