//
//  GarbageView.swift
//  MyDragAndDrop(Image galary)
//
//  Created by Pavel Spitcyn on 07.06.2021.
//

import UIKit

class GarbageView: UIView, UIDropInteractionDelegate {

    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        backgroundColor = .clear
        let trashImage = UIImage.imageFromSystemBarButton(.trash)
        let myButton = UIButton(frame: CGRect(x: 0, y: 0, width: bounds.height, height: bounds.height))
        self.addSubview(myButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.subviews.count > 0 {
            self.subviews[0].frame = CGRect(x: bounds.width - bounds.height, y: 0, width: bounds.height, height: bounds.height)
        }
    }
    
}
