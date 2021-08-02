//
//  MosaicViewController.swift
//  MyGallery
//
//  Created by Pavel Spitcyn on 30.07.2021.
//

import UIKit

class MosaicViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var mosaicCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(reloadMosaicCollectionView), name: .reloadMosaicData, object: nil)
    }

    
    //MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PhotoManager.shared().imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MosaicCollectionViewCell", for: indexPath) as! MosaicCollectionViewCell
        
        cell.imageView.image = PhotoManager.shared().imagesArray[indexPath.row]
        
        return cell
    }
    
    
    //MARK: - UICollectionViewDelegateFlowLayout
    
    //To set 3 cells per row
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = mosaicCollectionView.bounds.width / 3 - 1
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    
    //MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "iPhone", bundle: nil)
        let scrollViewController = storyboard.instantiateViewController(withIdentifier: "ScrollViewController") as! ScrollViewController

        //scrollViewController.image = PhotoManager.shared().imagesArray[indexPath.row]
        
        scrollViewController.image = PhotoManager.shared().grabHighQualityPhoto(index: indexPath.row)

        self.navigationController?.pushViewController(scrollViewController, animated: true)
    }

    
    //MARK: - Functions
    
    @objc
    func reloadMosaicCollectionView() {
        
        DispatchQueue.main.async {
            self.mosaicCollectionView.reloadData()
        }
    }
}


//MARK: Notification extension

extension Notification.Name {
    static let reloadMosaicData = NSNotification.Name("reloadMosaicData")
}

