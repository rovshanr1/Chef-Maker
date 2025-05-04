//
//  EditProfile.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 02.05.25.
//

import SwiftUI
import Kingfisher

struct EditProfile: View {
    @StateObject  var viewModel = EditProfileViewModel(appState: AppState.shared)
    @ObservedObject var profileViewModel: ProfileViewModel
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    @State private var showSaveAlert = false
    @Binding var showTabBar: Bool
    
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
    
            VStack{
                headerSection()
                ScrollView{
                    profilePictureSection()
                    
                    textFieldSection()
                    
                }
            }
            .padding(.horizontal)
            .navigationBarBackButtonHidden(true)
            .background(AppColors.adaptiveMainTabView(for: colorScheme).ignoresSafeArea())
            .onTapGesture {
                hideKeyboard()
            }
          
        
    }
    
    @ViewBuilder
    private func headerSection() -> some View {
        HStack{
            Button(action: {
                showTabBar = true
                dismiss()
            }){
                Image(systemName: "chevron.backward")
                    .font(.custom("Poppins-Medium", size: 18))
                    .foregroundStyle(AppColors.adaptiveText(for: colorScheme).secondary)
            }
            

            
           Text("Edit Profile")
                .font(.custom("Poppins-SemiBold", size: 16))
                .frame(maxWidth: .infinity, alignment: .center)
            
            Button(action: {
                showSaveAlert = true
            }){
                Text("done")
                    .foregroundStyle(AppColors.adaptiveText(for: colorScheme).secondary)
            }
            .alert("are you sure you want to save changes?", isPresented: $showSaveAlert){
                Button(action: {
                    Task{
                       await viewModel.updateProfile()
                    }
                }){
                    Text("Yes im sure!")
                }
                Button("No!", role: .cancel) {}
            }
            
        }
      
    }
    
    @ViewBuilder
    private func profilePictureSection() -> some View {
        VStack{
            ZStack {
                Circle()
                    .fill(.gray)
                    .frame(width: 92, height: 92)
                Group{
                    if let photoURL = profileViewModel.profile.photoURL, let url = URL(string: photoURL) {
                        KFImage(url)
                            .targetCache(CacheManager.shared.imageCache)
                            .fade(duration: 0.5)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                            .frame(width: 92, height: 92)
                        
                    } else {
                        Text(profileViewModel.profile.initials)
                            .font(.custom("Poppins-SemiBold", size: 16))
                            .foregroundColor(.white)
                    }
                }
                
            }
            
            Button(action: {
                showImagePicker = true
            }){
                Text("Change Profile Photo")
                    .font(.custom("Poppins-Medium", size: 14))
                    .padding(8)
                
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $selectedImage)
            }
            .onChange(of: selectedImage) { oldImage ,newImage in
                if let image = newImage{
                    Task{
                        try? await viewModel.uploadProfilePhoto(image)
                    }
                }
            }
       
            
            
        }
        .padding(.top)
    }
    
    @ViewBuilder
    private func textFieldSection() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 4){
                Text("Name")
                    .font(.custom("Poppins-Medium", size: 16))

                TextField("Name", text: $viewModel.name)
                    .font(.custom("Poppins-Medium", size: 14))
                    .autocorrectionDisabled(true)
                   
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
            
            VStack(alignment: .leading, spacing: 4){
                Text("Username")
                    .font(.custom("Poppins-Medium", size: 16))

                TextField("Username", text: $viewModel.userName)
                    .font(.custom("Poppins-Medium", size: 14))
                    .autocorrectionDisabled(true)

                   
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
            
            VStack(alignment: .leading, spacing: 4){
                Text("Bio")
                    .font(.custom("Poppins-Medium", size: 16))
                
                TextField("Bio", text: $viewModel.bio)
                    .font(.custom("Poppins-Medium", size: 14))
                    .autocorrectionDisabled(true)

                   
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
            
        }
        .padding(.top, 8)
    }
}

#Preview {
    EditProfile(profileViewModel: ProfileViewModel(appState: AppState.shared), showTabBar: .constant(true))
    
}
