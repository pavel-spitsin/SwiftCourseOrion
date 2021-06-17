//
//  ImageCollectionViewCell.swift
//  MyDragAndDrop(Image galary)
//
//  Created by Pavel Spitcyn on 07.06.2021.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    // MARK: - Public API
    var imageURL: URL? {
        didSet {updateUI()}
    }
    
    var changeAspectRatio: (() -> Void)?
    
    private func updateUI() {
        if let url = imageURL {
            imageView.image = nil
            spinner?.startAnimating()
            
            DispatchQueue.global(qos: .userInitiated).async {
                let urlContents = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    if let imageData = urlContents,
                       url == self.imageURL,
                    let image = UIImage(data: imageData) {
                        self.imageView?.image = image
                    } else {
                        self.imageView?.image = "Error 😡".emojiToImage()?.applyBlurEffect()
                        self.changeAspectRatio?()
                    }
                    self.spinner?.stopAnimating()
                }
            }
        }
    }
}
