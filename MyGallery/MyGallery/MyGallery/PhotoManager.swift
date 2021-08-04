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
    
    //Singleton
    private static var sharedManager: PhotoManager?
    private init() {}
    static func shared() -> PhotoManager {
            if sharedManager == nil {
                sharedManager = PhotoManager()
            }
            return sharedManager!
        }
    
    //To check permissions
    func checkPermissions() {
        PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized:
                    print("You Are Authrized To Access")
                    
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
    
    
    //Options for request
    func prepareOptionsForRequest() -> PHImageRequestOptions {
        let requestOption = PHImageRequestOptions()
        requestOption.isSynchronous = true
        requestOption.deliveryMode = .highQualityFormat
        return requestOption
    }
    
    //Options for fetch
    func prepareOptionsForFetch() -> PHFetchOptions {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        return fetchOptions
    }
    
    //Fetching images count
    func fetchResultCount() -> Int {
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: prepareOptionsForFetch())
        return fetchResult.count
    }
    
    
    func lowQualityImage(index: Int) -> UIImage {
        let imgManager = PHImageManager.default()
        var imageForReturn = UIImage()
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: prepareOptionsForFetch())
        imgManager.requestImage(for: fetchResult.object(at: index),
                                targetSize: CGSize(width: 200, height: 200),
                                contentMode: .aspectFill,
                                options: prepareOptionsForRequest()) { image, error in
            
            imageForReturn = image!
                    
        }
        return imageForReturn
    }
    
    func mediumQualityImage(index: Int) -> UIImage {
        let imgManager = PHImageManager.default()
        var imageForReturn = UIImage()
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: prepareOptionsForFetch())
        imgManager.requestImage(for: fetchResult.object(at: index),
                                targetSize: CGSize(width: 600, height: 600),
                                contentMode: .aspectFill,
                                options: prepareOptionsForRequest()) { image, error in
            
            imageForReturn = image!
                    
        }
        return imageForReturn
    }
    
    func highQualityImage(index: Int) -> UIImage {
        let imgManager = PHImageManager.default()
        var imageForReturn = UIImage()
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: prepareOptionsForFetch())
        imgManager.requestImage(for: fetchResult.object(at: index),
                                targetSize: CGSize(width: 1920, height: 1080),
                                contentMode: .aspectFill,
                                options: prepareOptionsForRequest()) { image, error in
            
            imageForReturn = image!
                    
        }
        return imageForReturn
    }
    
}

