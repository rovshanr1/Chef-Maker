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
    
    
    var body: some View {
        ZStack {
            ScrollView {
                
                VStack(alignment: .leading, spacing: 12){
                    
                    //sighnout section
                    signOutSection()
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            
        }
        .background(AppColors.adaptiveMainTabView(for: colorScheme).ignoresSafeArea(.all))
        .frame(maxWidth: .infinity, alignment: .center)

    }
    
    
    @ViewBuilder
    func signOutSection() -> some View{
        VStack(alignment: .leading, spacing: 18) {
            Text("Sign Out")
                .font(.headline)
                
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
                    }
                }
            }
            .disabled(viewModel.isLoading)
        }
    }
}

#Preview {
    BurgerMenu(viewModel: ProfileViewModel(appState: AppState()))
}
