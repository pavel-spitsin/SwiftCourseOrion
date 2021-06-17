//
//  ImageGallery.swift
//  MyDragAndDrop(Image galary)
//
//  Created by Pavel Spitcyn on 07.06.2021.
//

import Foundation

struct ImageModel {
    var url: URL
    var aspectRatio: Double
}

struct ImageGallery {
    var images = [ImageModel]()
    
    init() {
        self.images = [ImageModel]()
    }
}
