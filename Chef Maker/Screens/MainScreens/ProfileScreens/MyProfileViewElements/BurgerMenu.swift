//
//  BurgerMenu.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 02.05.25.
//

import SwiftUI

struct BurgerMenu: View {
    @StateObject var viewModel: ProfileViewModel
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    init(appState: AppState, profileUser: ProfileModel) {
        _viewModel = StateObject(wrappedValue: ProfileViewModel(appState: appState, profileUser: profileUser))
    }
    var body: some View {

NavigationStack{
    ScrollView {
        VStack(alignment: .leading, spacing: 12){
            //sighnout section
            signOutSection()
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
        .navigationBarBackButtonHidden(true)
        .background(EnableSwipeBackGesture())
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
      
        
    }
    .background(AppColors.adaptiveMainTabView(for: colorScheme).ignoresSafeArea(.all))
    .toolbar {
        ToolbarItem(placement: .topBarLeading) {
            Button(action: {
                dismiss()
            }){
                Image(systemName: "chevron.backward")
                    .font(.headline)
                    .foregroundStyle(AppColors.adaptiveText(for: colorScheme).secondary)
            }
            .padding(8)
        }
    }

}

}


@ViewBuilder
func headerSection() -> some View{
    HStack{
        Button(action: {
            dismiss()
        }){
            Image(systemName: "chevron.backward")
                .font(.headline)
                .foregroundStyle(AppColors.adaptiveText(for: colorScheme).secondary)
        }
        .padding(8)
        
        Text("Seting")
            .font(.custom("Poppins-Bold", size: 24))
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.trailing, 32)
        
    }
    
    
}

@ViewBuilder
func yourAccountPrivacy() -> some View{
    VStack {
        
    }
}

@ViewBuilder
func signOutSection() -> some View{
    VStack(alignment: .leading, spacing: 18) {
        
        Text("Sign out")
            .font(.custom("Poppins-SemiBold", size: 18))
        
        Button(action: {
            Task{
                await viewModel.signOut()
            }
        }){
            if viewModel.isLoading{
                ProgressView()
            }else{
                HStack(spacing: 12){
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .foregroundStyle(AppColors.deleteButtonColor)
                    
                    Text("Sign out")
                        .font(.custom("Poppins-Medium", size: 14))
                        .foregroundStyle(AppColors.deleteButtonColor)
                }
            }
        }
        .disabled(viewModel.isLoading)
    }
    .padding(8)
}
}

#Preview {
    BurgerMenu(appState: AppState(), profileUser: MockData.preview)
        .environmentObject(AppState())
}
