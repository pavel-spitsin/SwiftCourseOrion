//
//  AppDelegate.swift
//  MyGallery
//
//  Created by Pavel Spitcyn on 30.07.2021.
//

import UIKit
import Photos

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized:
                    print("You Are Authrized To Access")
                    /*
                    let fetchOptions = PHFetchOptions()
                    let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                    print("Found number of:  \(allPhotos.count) images")*/
                    
                    /*
                    let photoFetcher = PhotoFetcher.shared()
                    photoFetcher.images = allPhotos as! [UIImage]()
                    */
                    
                    DispatchQueue.main.async {
                        /*
                        let photoFetcher = PhotoLibraryController()
                        self.navigationController?.pushViewController(photoLibraryVC, animated: true)
 */

                    }
                    
                    
                case .denied, .restricted:
                    print("Not allowed")
                case .notDetermined:
                    print("Not determined yet")
                default:
                    fatalError()
                }
            }
        
        
        return true
    }


}

