//
//  ChangePhotoView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 05.05.25.
//

import SwiftUI
import PhotosUI
import Kingfisher

struct ChangePhotoView: View {
    @StateObject var viewModel: EditProfileViewModel
    @StateObject var profileViewModel: ProfileViewModel
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    @State private var showAlert = false
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var selectedItem: PhotosPickerItem?
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    
    init(appState: AppState) {
        _viewModel = StateObject(wrappedValue: EditProfileViewModel(appState: appState))
         _profileViewModel = StateObject(wrappedValue: ProfileViewModel(appState: appState))
     }
    var body: some View {
        VStack{
            ZStack {
                Circle()
                    .fill(.gray)
                    .frame(width: 62, height: 62)
                Group{
                    if let photoURL = profileViewModel.profile.photoURL, let url = URL(string: photoURL) {
                        KFImage(url)
                            .targetCache(CacheManager().imageCache)
                            .fade(duration: 0.5)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                            .frame(width: 62, height: 62)
                    } else {
                        Text(profileViewModel.profile.initials)
                            .font(.custom("Poppins-SemiBold", size: 16))
                            .foregroundColor(.white)
                    }
                }
                
            }
            
            Divider()
                .tint(AppColors.adaptiveText(for: colorScheme))
                .padding([.horizontal, .top])
            
            VStack(spacing: 26) {
                PhotosPicker(selection: $selectedItem,
                             matching: .images,
                             photoLibrary: .shared()){
                    HStack(spacing: 12){
                        Image(systemName: "photo")
                            .font(.system(size: 26))
                            .foregroundStyle(AppColors.adaptiveText(for: colorScheme).opacity(0.6))
                        Text("Chose your photo from your library")
                            .foregroundStyle(AppColors.adaptiveText(for: colorScheme).secondary)
                    }
                    .onChange(of: selectedItem) { oldImage ,newItem in
                        if let newItem {
                            Task{
                                if let data = try? await newItem.loadTransferable(type: Data.self),
                                   let uiImage = UIImage(data: data) {
                                    try await viewModel.uploadProfilePhoto(uiImage)
                                }
                            }
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
             
                
                
                Button(action: {
                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                        sourceType = .camera
                        DispatchQueue.main.async {
                            showImagePicker = true
                        }
                    }
                }){
                    HStack(spacing: 12){
                        Image(systemName: "camera")
                            .font(.system(size: 24))
                            .foregroundStyle(AppColors.adaptiveText(for: colorScheme).opacity(0.6))
                        
                        
                        Text("Take Photo ")
                            .foregroundStyle(AppColors.adaptiveText(for: colorScheme).secondary)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(image: $selectedImage, sourceType: sourceType)
                        .ignoresSafeArea(.all)
                }
                .onChange(of: selectedImage) { oldImage ,newImage in
                    if let image = newImage{
                        Task{
                            try? await viewModel.uploadProfilePhoto(image)
                        }
                    }
                }
              
                
                
                Button(action: {
                    Task{
                        await viewModel.deleteProfilePhoto()
                    }
                }){
                    HStack(spacing: 12){
                        Image(systemName: "trash")
                            .font(.system(size: 26))
                            .foregroundStyle(AppColors.deleteButtonColor)
                            .padding([.leading, .trailing], 4)
                        Text("Delete current photo")
                            .foregroundStyle(AppColors.deleteButtonColor.opacity(0.8))
                    }
                }
                .disabled(viewModel.isDeletingPhoto)
                .frame(maxWidth: .infinity, alignment: .leading)
               
                
                Text("Your profile picture is visible to everyone on and off Chef Maker")
                    .font(.custom("Poppins-Medium", size: 12))
                    .foregroundStyle(.gray.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.leading, .top])
        }
        .padding([.bottom,.top], 32)
        
    }
}

#Preview {
    EditProfile(appState: AppState(), showTabBar: .constant(true))
}
