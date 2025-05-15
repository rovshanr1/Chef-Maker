//
//  PostView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 03.05.25.
//

import SwiftUI
import Photos

struct PostView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    @State var showAddNewPostTitleView: Bool = false
    @StateObject private var service = PhotoLibraryManager()
    @State private var croppedImage: UIImage? = nil
    
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 16){
                //Header Section
                header()
                
                photoPreview()
                
            }
            .background(
                AppColors.adaptiveMainTabView(for: colorScheme)
                    .ignoresSafeArea(edges: .all)
            )
            .onAppear{
                requestPhotoLibraryAccess()
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $showAddNewPostTitleView) {
                if let croppedImage = croppedImage{
                    PostTitleView(selectedImage: croppedImage)
                }
            }
        }
        
    }
    
    
    @ViewBuilder
    func header() -> some View {
        HStack {
            Button(action: {
                dismiss()
            }){
                Text("Close")
                    .font(.custom("Poppins-Regular", size: 14))
            }
            .foregroundStyle(AppColors.adaptiveText(for: colorScheme).opacity(0.7))
            
            Spacer(minLength: 0)
            
            Text("New Post")
                .font(.custom("Poppins-SemiBold", size: 18))
            
            Spacer(minLength: 0)
            
            Button(action: {
                showAddNewPostTitleView = true
            }){
                Text("Next")
                    .font(.custom("Poppins-Regular", size: 14))
            }
            .foregroundStyle(AppColors.adaptiveText(for: colorScheme).opacity(0.7))
        }
        .padding([.top, .horizontal])
     
    }
    
    @ViewBuilder
    func photoPreview() -> some View {
        VStack{
            SelectedImagePreview(service: service, croppedImage: $croppedImage)
            Divider()
            CustomImagePickerGridView(viewModel: service)
        }

    }
    
    private func requestPhotoLibraryAccess() {
        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized || status == .limited {
                service.fetchImages()
            }
        }
    }
}

#Preview {
    PostView()
}
