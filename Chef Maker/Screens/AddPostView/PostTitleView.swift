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
    
    //Paramater States
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var ingredients: String = ""
    @State private var category: String = ""
    @State private var difficulty: String = ""
    @State private var nutrients: String = ""
    @State var selectedHour: Int = 0
    @State var selectedMinute: Int = 1
    @State private var selectTime: Int = 0
    @State private var errorMessage: String?
    @State private var isLoading = false

    //Navigation States
    @State private var backImagePickerView: Bool = false
    @State private var showHourPicker: Bool = false
    @State private var showMinutePicker: Bool = false
    
    @StateObject private var viewModel: PostViewModel
    
    init(appState: AppState, selectedImage: UIImage) {
        _viewModel = StateObject(wrappedValue: PostViewModel(appState: appState))
        self.selectedImage = selectedImage
    }
    
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 16){
                header()
                
                ScrollView(showsIndicators: false){
                    VStack(spacing: 16){
                        imageView()
                        Divider()
                        textFieldSection()
                    }
                }
            }
            .background(
                AppColors.adaptiveMainTabView(for: colorScheme)
                    .ignoresSafeArea(edges: .all)
            )
            .navigationDestination(isPresented: $backImagePickerView, destination: {
                PostView()
            })
            .navigationBarBackButtonHidden(true)
            .alert("Opps", isPresented: Binding(get: { errorMessage != nil }, set: { _ in errorMessage = nil })) {
                Button("Okay", role: .cancel){}
            }message: {
                Text(errorMessage ?? "")
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
    
    @ViewBuilder
    func header() -> some View {
        HStack {
            Button(action: {
                backImagePickerView = true
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
            Text("Your Recipe Title")
                .font(.custom("Poopins-Medium", size: 14))
                .foregroundStyle(AppColors.adaptiveText(for: colorScheme).opacity(0.6))
            TextField("Title", text: $title)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )
            
            Text("Your Recipe Description")
                .font(.custom("Poopins-Medium", size: 14))
                .foregroundStyle(AppColors.adaptiveText(for: colorScheme).opacity(0.6))
            
            TextEditor(text: $description)
                .foregroundStyle(.gray)
                .scrollContentBackground(.hidden)
                .frame(height: 140)
                .padding(10)
                .background(AppColors.adaptiveMainTabView(for: colorScheme))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(AppColors.adaptiveText(for: colorScheme).opacity(0.2), lineWidth: 1)
                )
                .font(.custom("Poppins-Regular", size: 14))
            
            
            VStack(spacing: 16){
                
                Text("How long will your delicious dish take to cook?")
                    .font(.custom("Poppins-Regular", size: 14))
                    .foregroundStyle(AppColors.adaptiveText(for: colorScheme).opacity(0.6))

                HStack(spacing: 8) {
                    Button(action:{
                        showHourPicker = true
                    }) {
                        Text(("Hour: \(selectedHour)h"))
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.ultraThinMaterial)
                            )
                        
                    }
                    .foregroundStyle(AppColors.adaptiveText(for: colorScheme).opacity(0.6))
                    .sheet(isPresented: $showHourPicker) {
                        HourSheet(hour: $selectedHour)
                            .presentationDetents([.height(350)])
                            .presentationDragIndicator(.visible)
                    }
                    .padding(.trailing)
                    
                    Button(action:{
                        showMinutePicker = true
                    }) {
                        Text(("Hour: \(selectedMinute)m"))
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.ultraThinMaterial)
                            )
                        
                    }
                    .foregroundStyle(AppColors.adaptiveText(for: colorScheme).opacity(0.6))
                    .sheet(isPresented: $showMinutePicker) {
                        MinuteSheet(minute: $selectedMinute)
                            .presentationDetents([.height(350)])
                            .presentationDragIndicator(.visible)
                    }
                    .padding(.leading)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
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
            cookingTime: "\(selectedHour)h \(selectedMinute)m",
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



#Preview {
    PostTitleView(appState: AppState(), selectedImage: UIImage())
}
