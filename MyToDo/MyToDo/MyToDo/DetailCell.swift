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
}

class DetailCell: UITableViewCell, UITextViewDelegate {

    var indexPath = IndexPath()
    let checkmarkColor: CGColor = UIColor.lightGray.cgColor
    
    weak var delegate: DetailCellDelegate?
    
    @IBOutlet weak var checkmarkButton: UIButton!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func checkmarkAction(_ sender: UIButton) {

        checkmarkButton.layer.borderColor = UIColor.systemGreen.cgColor

        let circleView = UIView()
        circleView.frame.size = CGSize(width: checkmarkButton.frame.width - 8,
                                       height: checkmarkButton.frame.height - 8)
        circleView.center = CGPoint(x: checkmarkButton.frame.size.width  / 2,
                                    y: checkmarkButton.frame.size.height / 2)
        circleView.layer.cornerRadius = circleView.bounds.height / 2
        circleView.backgroundColor = UIColor(cgColor: checkmarkButton.layer.borderColor!)
        checkmarkButton.addSubview(circleView)
        
        textView.textColor = UIColor.lightGray
    }
    
    @IBAction func detailButtonAction(_ sender: UIButton) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
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
    
    
    //MARK: - UITextViewDelegate

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
}
