//
//  CarouselViewController.swift
//  MyGallery
//
//  Created by Pavel Spitcyn on 30.07.2021.
//

import UIKit

class CarouselViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {

    let photoManager = PhotoManager()
    let cellScale: CGFloat = 0.6
    
    @IBOutlet weak var carouselCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carouselCollectionView.decelerationRate = .fast
    }
    
    override func viewWillLayoutSubviews() {
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScale)
        let cellHeight = floor(screenSize.height * cellScale)
        let insetX = (view.bounds.width - cellWidth) / 2.0
        let insetY = (view.bounds.height - cellHeight) / 2.0
        
        let layout = carouselCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        carouselCollectionView.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        photoManager.fetchingResult()
    }

    
    //MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoManager.fetchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCollectionViewCell", for: indexPath) as! CarouselCollectionViewCell
        cell.imageView.image = photoManager.fetchImageWithIndexAndQuality(index: indexPath.row, quality: .medium)
        return cell
    }
    
    
    //MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let scrollViewController = storyboard.instantiateViewController(withIdentifier: "ScrollViewController") as! ScrollViewController
        scrollViewController.focusedCellIndexPath = indexPath
        self.navigationController?.pushViewController(scrollViewController, animated: true)
    }
    
    
    //MARK: - UIScrollViewDelegate

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let layout = carouselCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
        
        targetContentOffset.pointee = offset
    }
}
