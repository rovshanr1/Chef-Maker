//
//  EditProfile.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 02.05.25.
//

import SwiftUI
import Kingfisher

struct EditProfile: View {
    @EnvironmentObject var appState : AppState
    @StateObject  var viewModel: EditProfileViewModel
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    @State private var showSaveAlert = false
    @State private var showChangeImageSheet = false
    @State private var backToProfile: Bool = false
    @Binding var showTabBar: Bool
    
    
    init(appState: AppState, showTabBar: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: EditProfileViewModel(appState: appState))
        self._showTabBar = showTabBar
    }
    
    var body: some View {
        
        NavigationStack{
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
            .navigationDestination(isPresented: $backToProfile) {
                MyProfileView(appState: appState, showTabBar: $showTabBar)
            }
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
                    .font(.headline)
                    .foregroundStyle(AppColors.adaptiveText(for: colorScheme).secondary)
            }
            
            Text("Edit Profile")
                .font(.custom("Poppins-SemiBold", size: 16))
                .padding(.leading, 26)
                .frame(maxWidth: .infinity, alignment: .center)
            
            
            Button(action: {
                showSaveAlert = true
            }){
                Text("done")
                    .font(.custom("Poppins-Regular", size: 18))
                    .foregroundStyle(AppColors.adaptiveText(for: colorScheme).secondary)
            }
            .alert("are you sure you want to save changes?", isPresented: $showSaveAlert){
                
                Button("No!", role: .cancel){}
                
                Button(action: {
                    Task{
                        showTabBar = true
                        await refreshData()
                        dismiss()
                    }
                }){
                    Text("Yes im sure!")
                }
                
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .center)
        
    }
    
    @ViewBuilder
    private func profilePictureSection() -> some View {
        VStack{
            ZStack {
                Circle()
                    .fill(.gray)
                    .frame(width: 92, height: 92)
                Group{
                    if let photoURL = viewModel.profile.photoURL, !photoURL.isEmpty, let url = URL(string: photoURL) {
                        KFImage(url)
                            .targetCache(CacheManager().imageCache)
                            .fade(duration: 0.5)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                            .frame(width: 92, height: 92)
                            .id(photoURL)
                        
                    } else {
                        Text(viewModel.profile.initials)
                            .font(.custom("Poppins-SemiBold", size: 16))
                            .foregroundColor(.white)
                    }
                }
                
            }
            
            Button(action: {
                showChangeImageSheet = true
            }){
                Text("Change Profile Photo")
                    .font(.custom("Poppins-Medium", size: 14))
                    .padding(8)
                
            }
            .sheet(isPresented: $showChangeImageSheet) {
                ChangePhotoView(appState: appState)
                    .presentationDetents([.height(350)])
                    .presentationDragIndicator(.visible)
                    .presentationCornerRadius(22)
                    .onDisappear{
                        viewModel.loadProfile()
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
                    .font(.custom("Poppins-Regular", size: 16))
                
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
                    .font(.custom("Poppins-Regular", size: 16))
                
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
                    .font(.custom("Poppins-Regular", size: 16))
                
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
    
    func refreshData() async {
        await viewModel.updateProfile()
    }
}

#Preview {
    EditProfile(appState: AppState(), showTabBar: .constant(true))
}
