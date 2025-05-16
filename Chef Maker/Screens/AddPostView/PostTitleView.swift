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
    
    let selectedImage: UIImage
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var ingredients: String = ""
    @State private var cookingTime: String = ""
    @State private var category: String = ""
    @State private var difficulty: String = ""
    @State private var nutrients: String = ""
    
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    @StateObject private var viewModel: PostViewModel
    
    init(appState: AppState, selectedImage: UIImage) {
        _viewModel = StateObject(wrappedValue: PostViewModel(appState: appState))
        self.selectedImage = selectedImage
     }
    
    
    var body: some View {
        
        VStack(spacing: 16){
            header()
            
            ScrollView{
                imageView()
                Divider()
                
            }
        }
        .background(
            AppColors.adaptiveMainTabView(for: colorScheme)
                .ignoresSafeArea(edges: .all)
        )
        .navigationBarBackButtonHidden(true)
       
    }
    
    @ViewBuilder
    func header() -> some View {
        HStack {
            Button(action: {
                dismiss()
            }){
                Image(systemName: "chevron.backward")
                    .font(.custom("Poppins-Regular", size: 14))
            }
            .foregroundStyle(AppColors.adaptiveText(for: colorScheme).opacity(0.7))
            
            Spacer(minLength: 0)
            
            Text("Description")
                .font(.custom("Poppins-SemiBold", size: 18))
            
            Spacer(minLength: 0)
            
            Button(action: {
                Task{
                    await handlePost()
                }
            }){
                if isLoading {
                    ProgressView()
                } else {
                    Text("Post")
                        .font(.custom("Poppins-Regular", size: 14))
                }
            }
            .disabled(isLoading)
            .foregroundStyle(AppColors.adaptiveText(for: colorScheme).opacity(0.7))
        }
        .padding([.top, .horizontal])
        
    }
    
    @ViewBuilder
    func imageView() -> some View {
        VStack(spacing: 20){
            Image(uiImage: selectedImage)
                .resizable()
                .scaledToFill()
                .foregroundStyle(.gray.opacity(0.2))
                .frame(height: 300)
                .clipped()
        }
        .padding(.horizontal)
    }
    
    
    func handlePost() async {
        guard !title.isEmpty, !description.isEmpty else {
            errorMessage = "All Text Fields Are Required!"
            return
        }
        
        isLoading = true
        
        let form = PostFormData(
            title: title,
            description: description,
            ingredients: ingredients.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) },
            cookingTime: cookingTime,
            category: category,
            difficulty: difficulty,
            nutrients: nutrients
        )
        
        do {
            try await viewModel.uploadPost(image: selectedImage, form: form)
            await MainActor.run {
                dismiss()
            }
        } catch {
            await MainActor.run {
                errorMessage = error.localizedDescription
            }
        }
        
        isLoading = false
    }
    
}


