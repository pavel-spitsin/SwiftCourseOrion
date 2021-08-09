//
//  MosaicViewController.swift
//  MyGallery
//
//  Created by Pavel Spitcyn on 30.07.2021.
//

import UIKit

class MosaicViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let photoManager = PhotoManager()
    var indexPathForFocus = IndexPath()
    
    @IBOutlet weak var mosaicCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserChecker.shared.isNewUser() {
            let welcomeVC = storyboard?.instantiateViewController(identifier: "WelcomeViewController") as! PageViewController
            welcomeVC.modalPresentationStyle = .fullScreen
            present(welcomeVC, animated: true, completion: nil)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(reloadMosaicCollectionView), name: .reloadMosaicData, object: nil)
        photoManager.checkPermissions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        photoManager.fetchingResult()
    }

    
    //MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoManager.fetchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MosaicCollectionViewCell", for: indexPath) as! MosaicCollectionViewCell
        cell.imageView.image = photoManager.fetchImageWithIndexAndQuality(index: indexPath.row, quality: .low)
        return cell
    }
    
    
    //MARK: - UICollectionViewDelegateFlowLayout
    
    //To set 3 cells per row
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width = CGFloat()
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            width = mosaicCollectionView.bounds.width / 6 - 1
        default:
            width = mosaicCollectionView.bounds.width / 3 - 1
        }
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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let scrollViewController = storyboard.instantiateViewController(withIdentifier: "ScrollViewController") as! ScrollViewController
        scrollViewController.focusedCellIndexPath = indexPath
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


    //MARK: - Notification extension

extension Notification.Name {
    static let reloadMosaicData = NSNotification.Name("reloadMosaicData")
}
