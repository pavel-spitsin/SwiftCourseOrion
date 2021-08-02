//
//  PhotoFetcher.swift
//  MyGallery
//
//  Created by Pavel Spitcyn on 30.07.2021.
//

import Foundation
import UIKit
import Photos

class PhotoManager {
    
    var imagesArray = [UIImage]()
    
    private static var sharedManager: PhotoManager?
    
    private init() {}
    
    static func shared() -> PhotoManager {
            if sharedManager == nil {
                sharedManager = PhotoManager()
            }
            return sharedManager!
        }
    
    
    func checkPermissions() {
        PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized:
                    print("You Are Authrized To Access")
                    self.imagesArray.removeAll()
                    self.grabPhotos()
                    NotificationCenter.default.post(name: NSNotification.Name("reloadMosaicData"), object: nil, userInfo: nil)
                    NotificationCenter.default.post(name: NSNotification.Name("reloadCarouselData"), object: nil, userInfo: nil)

                case .denied, .restricted:
                    print("Not allowed")
                case .notDetermined:
                    print("Not determined yet")
                default:
                    fatalError()
                }
            }
    }

    
    func grabPhotos() {
        
        let imgManager = PHImageManager.default()
        
        let requestOption = PHImageRequestOptions()
        requestOption.isSynchronous = true
        requestOption.deliveryMode = .opportunistic
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)

        if fetchResult.count > 0 {

            for i in 0..<fetchResult.count {
                imgManager.requestImage(for: fetchResult.object(at: i), targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: requestOption) { image, error in

                    self.imagesArray.append(image!)
                    }
                }
            }
    }
    
    
    func grabHighQualityPhoto(index: Int) -> UIImage {
        
        let imgManager = PHImageManager.default()
        var imageForReturn = UIImage()
        
        let requestOption = PHImageRequestOptions()
        requestOption.isSynchronous = true
        requestOption.deliveryMode = .highQualityFormat
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)

        imgManager.requestImage(for: fetchResult.object(at: index),
                                targetSize: CGSize(width: 1920, height: 1080),
                                contentMode: .aspectFill,
                                options: requestOption) { image, error in
            
            imageForReturn = image!
                    
        }
        
        return imageForReturn
    }
}

