//
//  PhotoLibraryManager.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 15.05.25.
//

import SwiftUI
import Photos

class PhotoLibraryManager: ObservableObject {
    @Published var selectedImage: UIImage?
    @Published var allImages: [UIImage] = []
    
    
    func fetchImages() {
         let fetchOptions = PHFetchOptions()
         fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

         let result = PHAsset.fetchAssets(with: .image, options: fetchOptions)
         let imageManager = PHImageManager.default()

         result.enumerateObjects { asset, _, _ in
             let targetSize = CGSize(width: 200, height: 200)
             let options = PHImageRequestOptions()
             options.isSynchronous = false
             options.deliveryMode = .highQualityFormat

             imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: options) { image, _ in
                 if let image = image {
                     DispatchQueue.main.async {
                         self.allImages.append(image)
                         if self.selectedImage == nil {
                             self.selectedImage = image
                         }
                     }
                 }
             }
         }
     }
    
}
