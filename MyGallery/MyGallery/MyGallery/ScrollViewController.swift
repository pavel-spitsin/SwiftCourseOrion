//
//  ScrollViewController.swift
//  MyGallery
//
//  Created by Pavel Spitcyn on 30.07.2021.
//

import UIKit

class ScrollViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var itemsForShare = [UIImage]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func shareBarButtonAction(_ sender: UIBarButtonItem) {
        let shareController = UIActivityViewController(activityItems: itemsForShare, applicationActivities: nil)
        present(shareController, animated: true, completion: nil)
    }

    var image = UIImage()
    var imageIndex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PhotoManager.shared().imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SCVCell", for: indexPath) as! SCVCell
        
        //cell.imageView.image = PhotoManager.shared().imagesArray[indexPath.row]
        DispatchQueue.main.async {
            cell.imageView.image = PhotoManager.shared().highQualityImage(index: indexPath.row)
            self.itemsForShare.append(cell.imageView.image!)
        }

        
        cell.scrollview.contentInsetAdjustmentBehavior = .never
        
        // Provide a maximumZoomScale of greater that 1
        // 1 is the default value, if not set won;t zoom
        cell.scrollview.minimumZoomScale = 1.0
        cell.scrollview.maximumZoomScale = 5.0
        
        return cell
    }
    
    
    //MARK: - UICollectionViewDelegateFlowLayout
    
    //To set 3 cells per row
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        
        return CGSize(width: width, height: height)
    }

}
