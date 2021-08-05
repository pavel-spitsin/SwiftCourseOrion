//
//  CarouselViewController.swift
//  MyGallery
//
//  Created by Pavel Spitcyn on 30.07.2021.
//

import UIKit

class CarouselViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var carouselCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(reloadMosaicCollectionView), name: .reloadCarouselData, object: nil)
    }

    
    //MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PhotoManager.shared().fetchResultCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCollectionViewCell", for: indexPath) as! CarouselCollectionViewCell
        
        DispatchQueue.global(qos: .userInteractive).async {
            let image = PhotoManager.shared().mediumQualityImage(index: indexPath.row)
            
            DispatchQueue.main.async {
                cell.imageView.image = image
            }
        }
        
        return cell
    }
    
    
    //MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "iPhone", bundle: nil)
        let scrollViewController = storyboard.instantiateViewController(withIdentifier: "ScrollViewController") as! ScrollViewController

        scrollViewController.cellIndexPath = indexPath
        
        self.navigationController?.pushViewController(scrollViewController, animated: true)
    }
    
    
    //MARK: - Functions
    
    @objc
    func reloadMosaicCollectionView() {
        DispatchQueue.main.async {
            self.carouselCollectionView.reloadData()
        }
    }
}


    //MARK: - Notification extension

extension Notification.Name {
    static let reloadCarouselData = NSNotification.Name("reloadCarouselData")
}
