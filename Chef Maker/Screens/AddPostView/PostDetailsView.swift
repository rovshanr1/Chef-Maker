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
                    VStack(alignment: .leading){
                        IngredientsSection(viewModel: viewModel)
                        
                        Divider()
                        
                        showingTimeAndServingSheetSection()
                    }
                }
                
            }
            .background(Color.appsBackground)
            .navigationDestination(isPresented: $backRecipeDescriptionView){
                PostTitleView(appState: appState, selectedImage: selectedImage)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(Text("Recipe Details"))
            .alert("Opps", isPresented: Binding(get: { viewModel.errorMessage != nil }, set: { _ in viewModel.errorMessage = nil })){
                Button("OK", role: .cancel){}
            }message: {
                Text(viewModel.errorMessage ?? "")
            }
            .onTapGesture {hideKeyboard()}
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
    func showingTimeAndServingSheetSection() -> some View {
            HStack(spacing: 8) {
                VStack(spacing: 16){
                    Text("Time.")
                        .font(.custom("Poppins-Bold", size: 18))
                    
                    Button(action:{
                        showHourPicker = true
                    }) {
                            HStack{
                                if viewModel.selectedHour > 0{
                                    Text(("\(viewModel.selectedHour)h"))
                                    
                                }
                                Text(("\(viewModel.selectedMinute)mins"))
                            }
                            .frame(width: 100)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        .ultraThinMaterial,
                                        style: StrokeStyle(
                                            lineWidth: 2
                                        )
                                        
                                    )
                            )
                            
                        
                    }
                    .foregroundStyle(AppColors.adaptiveText(for: colorScheme).opacity(0.6))
                    .sheet(isPresented: $showHourPicker) {
                        TimeSheet(hour: $viewModel.selectedHour, minute: $viewModel.selectedMinute)
                            .presentationDetents([.height(350)])
                            .presentationDragIndicator(.visible)
                    }
                }
                .padding(.top)
                
                VStack(spacing: 16){
                    Text("Servings.")
                        .font(.custom("Poppins-Bold", size: 18))

                    Button(action:{
                        showMinutePicker = true
                    }) {
                        Text(("\(viewModel.serving) servings"))
                            .frame(width: 100)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        .ultraThinMaterial,
                                        style: StrokeStyle(
                                            lineWidth: 2
                                        )
                                    )
                            )
                            
                    }
                    .foregroundStyle(AppColors.adaptiveText(for: colorScheme).opacity(0.6))
                    .sheet(isPresented: $showMinutePicker) {
                        ServingsSheet(serving: $viewModel.serving)
                            .presentationDetents([.height(350)])
                            .presentationDragIndicator(.visible)
                    }
                }
                .padding([.top, .leading])
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
        
        
    }
}

#Preview {
    PostDetailsView(appState: AppState(), selectedImage: UIImage())
}
