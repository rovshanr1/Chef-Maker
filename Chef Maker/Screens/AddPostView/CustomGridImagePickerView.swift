//
//  CustomGridImagePickerView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 15.05.25.
//

import SwiftUI

struct CustomImagePickerGridView: View {
    @ObservedObject var viewModel: PhotoLibraryManager
    let columns = [GridItem(.adaptive(minimum: 100), spacing: 4)]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 4) {
                ForEach(Array(viewModel.allImages.enumerated()), id: \.offset) { index, image in
                    
                    ZStack{
                        Rectangle()
                            .fill(Color.white.opacity(0.3))
                            .frame(width: 100, height: 100)
                        
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipped()
                    }
                    .frame(width: 100, height: 100)
                    .overlay(
                        Rectangle()
                            .stroke(viewModel.selectedImage == image ? Color.blue : Color.clear, lineWidth: 3)
                    )
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.selectedImage = image
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    PostView()
}
