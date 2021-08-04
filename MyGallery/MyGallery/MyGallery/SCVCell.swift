//
//  SCVCell.swift
//  MyGallery
//
//  Created by Павел on 03.08.2021.
//

import UIKit

class SCVCell: UICollectionViewCell, UIScrollViewDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollview: UIScrollView!

    
    //MARK: - UIScrollViewDelegate
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        scrollview.zoomScale = 1.0
    }
    
}
