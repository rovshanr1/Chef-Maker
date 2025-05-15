//
//  CustomGridImagePickerView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 15.05.25.
//

import SwiftUI

struct CustomImagePickerGridView: View {
    @ObservedObject var viewModel: PhotoLibraryManager
    let columns = [GridItem(.adaptive(minimum: 100), spacing: 8)]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(viewModel.allImages, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipped()
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(viewModel.selectedImage == image ? Color.blue : Color.clear, lineWidth: 3)
                        )
                        .onTapGesture {
                            withAnimation {
                                viewModel.selectedImage = image
                            }
                        }
                }
            }
            .padding()
        }
    }
}

#Preview {
    CustomImagePickerGridView(viewModel: PhotoLibraryManager())
}
