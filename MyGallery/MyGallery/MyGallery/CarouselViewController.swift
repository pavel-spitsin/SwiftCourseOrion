//
//  CarouselViewController.swift
//  MyGallery
//
//  Created by Pavel Spitcyn on 30.07.2021.
//

import UIKit

class CarouselViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    let photoManager = PhotoManager()
    
    @IBOutlet weak var carouselCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        carouselCollectionView.isPagingEnabled = true
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
        scrollViewController.cellIndexPath = indexPath
        self.navigationController?.pushViewController(scrollViewController, animated: true)
    }
    
    
    //MARK: - UICollectionViewDelegateFlowLayout
    
    //To set 1 cell per column
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 1.2
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
}
