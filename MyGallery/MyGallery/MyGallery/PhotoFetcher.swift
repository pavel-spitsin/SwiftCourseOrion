//
//  PhotoFetcher.swift
//  MyGallery
//
//  Created by Pavel Spitcyn on 30.07.2021.
//

import Foundation
import UIKit
import Photos

class PhotoFetcher {
    
    var imagesArray = [UIImage]()

    func grabPhotos() {
        
        let imgManager = PHImageManager.default()
        
        let requestOption = PHImageRequestOptions()
        requestOption.isSynchronous = true
        requestOption.deliveryMode = .highQualityFormat
        
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
}
