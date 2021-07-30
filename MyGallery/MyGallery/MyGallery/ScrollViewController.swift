//
//  ScrollViewController.swift
//  MyGallery
//
//  Created by Pavel Spitcyn on 30.07.2021.
//

import UIKit

class ScrollViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Provide a maximumZoomScale of greater that 1
        // 1 is the default value, if not set won;t zoom
        scrollView.maximumZoomScale = 5.0
    }
    
    
    
    //MARK: - UICollectionViewDataSource
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

}
