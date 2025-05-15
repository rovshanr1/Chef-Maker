//
//  ImagePickerViewModel.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 15.05.25.
//

import SwiftUI


class ImagePickerViewModel: ObservableObject{
    @Published var selectedImage: [UIImage] = []
    
    func togleSelection(for image: UIImage) {
        if selectedImage.contains(image) {
            selectedImage.removeAll() { $0 == image }
        }else{
            selectedImage.append(image)
        }
    }
    
    func isSelected(_ image: UIImage) -> Bool {
        return selectedImage.contains(image)
    }
    
    
}
