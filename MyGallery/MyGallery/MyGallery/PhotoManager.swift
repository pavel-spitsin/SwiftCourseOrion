//
//  PhotoFetcher.swift
//  MyGallery
//
//  Created by Pavel Spitcyn on 30.07.2021.
//

import Foundation
import UIKit
import Photos

enum ImageQuality {
    case low
    case medium
    case high
}

class PhotoManager {
    
    var fetchResult = PHFetchResult<PHAsset>()
    
    //To check permissions
    func checkPermissions() {
        PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized:
                    print("You Are Authrized To Access")
                    NotificationCenter.default.post(name: NSNotification.Name("reloadMosaicData"), object: nil, userInfo: nil)
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
    
    //Fetching result
    func fetchingResult() {
        fetchResult = PHAsset.fetchAssets(with: .image, options: prepareOptionsForFetch())
    }
    
    //Return image quality
    func imageQuality(quality: ImageQuality) -> CGSize {
        switch quality {
        case .low:
            return CGSize(width: 320, height: 240)
        case .medium:
            return CGSize(width: 640, height: 480)
        case .high:
            return CGSize(width: 1920, height: 1080)
        }
    }
    
    //Fetch image with index and quality
    func fetchImageWithIndexAndQuality(index: Int, quality: ImageQuality) -> UIImage {
        let imgManager = PHImageManager.default()
        var imageForReturn = UIImage()
        imgManager.requestImage(for: fetchResult.object(at: index),
                                targetSize: imageQuality(quality: quality),
                                contentMode: .aspectFill,
                                options: prepareOptionsForRequest()) { image, error in
            imageForReturn = image!
        }
        return imageForReturn
    }
}



