/// Copyright (c) 2018 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

struct PhotoManagerNotification {
  // Notification when new photo instances are added
  static let contentAdded = Notification.Name("com.raywenderlich.GooglyPuff.PhotoManagerContentAdded")
  // Notification when content updates (i.e. Download finishes)
  static let contentUpdated = Notification.Name("com.raywenderlich.GooglyPuff.PhotoManagerContentUpdated")
}

struct PhotoURLString {
  // Photo Credit: Devin Begley, http://www.devinbegley.com/
//    static let overlyAttachedGirlfriend = "https://i.imgur.com/UvqEgCv.png"
  static let overlyAttachedGirlfriend = "https://i.imgur.com/OT6v8qX.jpeg"
  static let successKid = "https://media1.giphy.com/media/VFNImnHckfBKHZDOIV/200.gif"
  static let lotsOfFaces = "https://i.ytimg.com/vi/qtopVFJK6N8/maxresdefault.jpg"
}

typealias PhotoProcessingProgressClosure = (_ completionPercentage: CGFloat) -> Void
typealias BatchPhotoDownloadingCompletionClosure = (_ error: NSError?) -> Void

final class PhotoManager {
  private init() {}
  static let shared = PhotoManager()
  
    
    private let concurrentPhotoQueue =
      DispatchQueue(
        label: "com.raywenderlich.GooglyPuff.photoQueue",
        attributes: .concurrent)

    
    
  private var unsafePhotos: [Photo] = []
  
    var photos: [Photo] {
      var photosCopy: [Photo]!

      // 1
      concurrentPhotoQueue.sync {

        // 2
        photosCopy = self.unsafePhotos
      }
      return photosCopy
    }
  
    func addPhoto(_ photo: Photo) {
      concurrentPhotoQueue.async(flags: .barrier) { [weak self] in
        // 1
        guard let self = self else {
          return
        }

        // 2
        self.unsafePhotos.append(photo)

        // 3
        DispatchQueue.main.async { [weak self] in
          self?.postContentAddedNotification()
        }
      }
    }

  
  func downloadPhotos(withCompletion completion: BatchPhotoDownloadingCompletionClosure?) {

    /*
    // 1
    DispatchQueue.global(qos: .userInitiated).async {
      var storedError: NSError?

      // 2
      let downloadGroup = DispatchGroup()
      for address in [PhotoURLString.overlyAttachedGirlfriend,
                      PhotoURLString.successKid,
                      PhotoURLString.lotsOfFaces] {
        let url = URL(string: address)

        // 3
        downloadGroup.enter()
        let photo = DownloadPhoto(url: url!) { _, error in
          if error != nil {
            storedError = error
          }

          // 4
          downloadGroup.leave()
        }
        PhotoManager.shared.addPhoto(photo)
      }

      // 5
      downloadGroup.wait()

      // 6
      DispatchQueue.main.async {
        completion?(storedError)
      }
    }
 */
    
    /*
    // 1
    var storedError: NSError?
    let downloadGroup = DispatchGroup()
    for address in [PhotoURLString.overlyAttachedGirlfriend,
                    PhotoURLString.successKid,
                    PhotoURLString.lotsOfFaces] {
      let url = URL(string: address)
      downloadGroup.enter()
      let photo = DownloadPhoto(url: url!) { _, error in
        if error != nil {
          storedError = error
        }
        downloadGroup.leave()
      }
      PhotoManager.shared.addPhoto(photo)
    }

    // 2
    downloadGroup.notify(queue: DispatchQueue.main) {
      completion?(storedError)
    }
 */
    
    /*
    var storedError: NSError?
    let downloadGroup = DispatchGroup()
    let addresses = [PhotoURLString.overlyAttachedGirlfriend,
                     PhotoURLString.successKid,
                     PhotoURLString.lotsOfFaces]
    let _ = DispatchQueue.global(qos: .userInitiated)
    DispatchQueue.concurrentPerform(iterations: addresses.count) { index in
      let address = addresses[index]
      let url = URL(string: address)
      downloadGroup.enter()
      let photo = DownloadPhoto(url: url!) { _, error in
        if error != nil {
          storedError = error
        }
        downloadGroup.leave()
      }
      PhotoManager.shared.addPhoto(photo)
    }
    downloadGroup.notify(queue: DispatchQueue.main) {
      completion?(storedError)
    }
*/
    
    
    
    var storedError: NSError?
    let downloadGroup = DispatchGroup()
    var addresses = [PhotoURLString.overlyAttachedGirlfriend,
                     PhotoURLString.successKid,
                     PhotoURLString.lotsOfFaces]

    // 1
    addresses += addresses + addresses

    // 2
    var blocks: [DispatchWorkItem] = []

    for index in 0..<addresses.count {
      downloadGroup.enter()

      // 3
      let block = DispatchWorkItem(flags: .inheritQoS) {
        let address = addresses[index]
        let url = URL(string: address)
        let photo = DownloadPhoto(url: url!) { _, error in
          if error != nil {
            storedError = error
          }
          downloadGroup.leave()
        }
        PhotoManager.shared.addPhoto(photo)
      }
      blocks.append(block)

      // 4
      DispatchQueue.main.async(execute: block)
    }

    // 5
    for block in blocks[3..<blocks.count] {

      // 6
      let cancel = Bool.random()
      if cancel {

        // 7
        block.cancel()

        // 8
        downloadGroup.leave()
      }
    }

    downloadGroup.notify(queue: DispatchQueue.main) {
      completion?(storedError)
    }

  }
  
  private func postContentAddedNotification() {
    NotificationCenter.default.post(name: PhotoManagerNotification.contentAdded, object: nil)
  }
}
