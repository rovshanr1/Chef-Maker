//
//  PostTitleVIew.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 15.05.25.
//

import SwiftUI

struct PostTitleView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    //Navigation States
    @State private var backImagePickerView: Bool = false
    @State private var showPostDitailsView: Bool = false
    
    //ViewModel
    @StateObject private var viewModel: PostViewModel
    
    //Constant
    let appState: AppState
    var selectedImage: UIImage
    
    init(appState: AppState, selectedImage: UIImage) {
        _viewModel = StateObject(wrappedValue: PostViewModel(appState: appState, selectedImage: selectedImage))
        self.appState = appState
        self.selectedImage = selectedImage
    }
    
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 16){
                ScrollView(showsIndicators: false){
                    VStack(spacing: 16){
                        imageView()
                        Divider()
                        textFieldSection()
                    }
                    .padding(.top)
                }
            }
            .background(
                Color.appsBackground
            )
            .navigationDestination(isPresented: $backImagePickerView, destination: {
                PostView()
            })
            .navigationDestination(isPresented: $showPostDitailsView, destination: {
                PostDetailsView(appState: appState, selectedImage: selectedImage)
            })
            .navigationBarBackButtonHidden(true)
            .alert("Opps", isPresented: Binding(get: { viewModel.errorMessage != nil }, set: { _ in viewModel.errorMessage = nil })) {
                Button("Okay", role: .cancel){}
            }message: {
                Text(viewModel.errorMessage ?? "")
            }
            .onTapGesture {
                hideKeyboard()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Recipe Title & Description")
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        backImagePickerView = true
                    }){
                        Image(systemName: "chevron.backward")
                            .font(.custom("Poppins-Regular", size: 14))
                    }
                    .foregroundStyle(AppColors.adaptiveText(for: colorScheme).opacity(0.7))
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        if viewModel.checkFormValidity(){
                            showPostDitailsView = true
                        }
                        
                    }){
                        Text("Next")
                            .font(.custom("Poppins-Regular", size: 14))
                    }
                    .foregroundStyle(AppColors.adaptiveText(for: colorScheme).opacity(0.7))
                    
                }
                
            }
        }
    }
    
    @ViewBuilder
    func imageView() -> some View {
        VStack(spacing: 20){
            Image(uiImage: viewModel.selectedImage)
                .resizable()
                .scaledToFill()
                .frame(height: 300)
                .clipped()
        }
        .background(
            Color(.gray.opacity(0.1))
            
        )
        .padding(.horizontal)
    }
    
    @ViewBuilder
    func textFieldSection() -> some View {
        VStack(alignment: .leading, spacing: 12){
            Text("Title")
                .font(.custom("Poopins-Medium", size: 14))
                .foregroundStyle(AppColors.adaptiveText(for: colorScheme).opacity(0.6))
            TextField("Your Recipe Title", text: $viewModel.title)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )
            
            CustomTexteditorField(
                title: "Description",
                placeholder: "Your Recipe Description",
                text: $viewModel.description)
        }
        .padding(.horizontal)
    }
    
}



#Preview {
    PostTitleView(appState: AppState(), selectedImage: UIImage())
}
