//
//  ImagePicker.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 04.05.25.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
   
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    var sourceType: UIImagePickerController.SourceType = .camera
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
           let picker = UIImagePickerController()
           picker.delegate = context.coordinator
           picker.sourceType = sourceType
           return picker
       }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {   }
    
    func makeCoordinator() -> Coordinator {
           Coordinator(self)
       }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
           let parent: ImagePicker
           init(_ parent: ImagePicker) { self.parent = parent }

           func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
               if let image = info[.originalImage] as? UIImage {
                   parent.image = image
               }
               parent.presentationMode.wrappedValue.dismiss()
           }
       }
}
