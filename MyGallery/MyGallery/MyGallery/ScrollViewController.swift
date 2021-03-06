//
//  ScrollViewController.swift
//  MyGallery
//
//  Created by Pavel Spitcyn on 30.07.2021.
//

import UIKit

class ScrollViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var itemsForShare = [UIImage]()
    var focusedCellIndexPath = IndexPath()
    let photoManager = PhotoManager()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func shareBarButtonAction(_ sender: UIBarButtonItem) {
        let shareController = UIActivityViewController(activityItems: itemsForShare, applicationActivities: nil)
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            shareController.popoverPresentationController?.barButtonItem = sender
            shareController.popoverPresentationController?.permittedArrowDirections = .any
            present(shareController, animated: true, completion: nil)
        default:
            present(shareController, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: UIApplication.willEnterForegroundNotification, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        photoManager.fetchingResult()
    }
    
    override func viewDidLayoutSubviews() {
        scrollToItem()
    }
    
    //Update cellIndexPath
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        focusedCellIndexPath = collectionView.indexPathsForVisibleItems[0]
    }
    
    
    //MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoManager.fetchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZoomCell", for: indexPath) as! ZoomCell
        
        itemsForShare.removeAll()
        
        cell.imageView.image = photoManager.fetchImageWithIndexAndQuality(index: indexPath.row, quality: .high)
        itemsForShare.append(cell.imageView.image!)

        cell.scrollview.contentInsetAdjustmentBehavior = .never
        
        // Provide a maximumZoomScale of greater that 1
        // 1 is the default value, if not set won;t zoom
        cell.scrollview.minimumZoomScale = 1.0
        cell.scrollview.maximumZoomScale = 5.0
        
        return cell
    }

    
    //MARK: - UICollectionViewDelegateFlowLayout
    
    //To set 1 cell per column
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    //MARK: - Functions
    
    @objc func willResignActive(_ notification: Notification) {
        scrollToItem()
    }
    
    func scrollToItem() {
        collectionView.isPagingEnabled = false
        collectionView.performBatchUpdates(nil) { (result) in
            self.collectionView.scrollToItem(at: self.focusedCellIndexPath, at: .centeredHorizontally, animated: false)
            self.collectionView.isPagingEnabled = true
        }
    }
}
