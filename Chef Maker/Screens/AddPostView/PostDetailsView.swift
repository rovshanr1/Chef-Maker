//
//  PostDetailsView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 27.05.25.
//

import SwiftUI

struct PostDetailsView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    //Navigation State
    @State private var backRecipeDescriptionView: Bool = false
    @State private var showHourPicker: Bool = false
    @State private var showMinutePicker: Bool = false
    
    @StateObject var viewModel: PostViewModel
    
    let appState: AppState
    let selectedImage: UIImage
    
    init(appState: AppState, selectedImage: UIImage) {
        _viewModel = StateObject(wrappedValue: PostViewModel(appState: appState, selectedImage: selectedImage))
        self.appState = appState
        self.selectedImage = selectedImage
    }
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16){
                ScrollView(showsIndicators: false){
                    VStack{
                        cookingTimeSelection()
                    }
                }
                
            }
            .navigationDestination(isPresented: $backRecipeDescriptionView){
                PostTitleView(appState: appState, selectedImage: selectedImage)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(Text("Recipe Details"))
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button(action: {
                        backRecipeDescriptionView = true
                    }){
                        Image(systemName: "chevron.backward")
                            .font(.custom("Poppins-Regular", size: 14))
                    }
                    .foregroundStyle(AppColors.adaptiveText(for: colorScheme).opacity(0.7))
                }
                
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {
                        Task{
                            let succes = await viewModel.handlePost()
                            if succes{
                                dismiss()
                            }
                        }
                    }){
                        if viewModel.isLoading {
                            ProgressView()
                        } else {
                            Text("Post")
                                .font(.custom("Poppins-Regular", size: 14))
                        }
                    }
                    .disabled(viewModel.isLoading)
                    .foregroundStyle(AppColors.adaptiveText(for: colorScheme).opacity(0.7))
                }
            }
        }
    }
    
    @ViewBuilder
    func cookingTimeSelection() -> some View {
        VStack(spacing: 16){
            Text("How long will your delicious dish take to cook?")
                .font(.custom("Poppins-Regular", size: 14))
                .foregroundStyle(AppColors.adaptiveText(for: colorScheme).opacity(0.6))
            
            HStack(spacing: 8) {
                Button(action:{
                    showHourPicker = true
                }) {
                    Text(("Hour: \(viewModel.selectedHour)h"))
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.ultraThinMaterial)
                        )
                    
                }
                .foregroundStyle(AppColors.adaptiveText(for: colorScheme).opacity(0.6))
                .sheet(isPresented: $showHourPicker) {
                    HourSheet(hour: $viewModel.selectedHour)
                        .presentationDetents([.height(350)])
                        .presentationDragIndicator(.visible)
                }
                .padding(.trailing)
                
                Button(action:{
                    showMinutePicker = true
                }) {
                    Text(("Minute: \(viewModel.selectedMinute)m"))
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.ultraThinMaterial)
                        )
                    
                }
                .foregroundStyle(AppColors.adaptiveText(for: colorScheme).opacity(0.6))
                .sheet(isPresented: $showMinutePicker) {
                    MinuteSheet(minute: $viewModel.selectedMinute)
                        .presentationDetents([.height(350)])
                        .presentationDragIndicator(.visible)
                }
                .padding(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.horizontal)
    }
}

#Preview {
    PostDetailsView(appState: AppState(), selectedImage: UIImage())
}
