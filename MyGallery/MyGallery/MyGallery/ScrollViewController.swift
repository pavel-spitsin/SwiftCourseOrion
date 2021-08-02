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
    
    var image = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image

        scrollView.contentInsetAdjustmentBehavior = .never
        
        // Provide a maximumZoomScale of greater that 1
        // 1 is the default value, if not set won;t zoom
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0

    }
    
    
    
    //MARK: - UIScrollViewDelegate
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

}
