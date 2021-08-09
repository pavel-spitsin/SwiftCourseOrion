//
//  MosaicCollectionViewCell.swift
//  MyGallery
//
//  Created by Pavel Spitcyn on 30.07.2021.
//

import UIKit

class MosaicCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func layoutSubviews() {
        imageView.frame = self.bounds
        super.layoutSubviews()
    }
}
