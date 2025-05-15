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
    
    
    var body: some View {
   
        VStack(spacing: 16){
            header()
            
            ScrollView{
                VStack(spacing: 20){
                    Image(uiImage: selectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .frame(height: 300)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
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
                //TODO: Post action
            }){
                Text("Post")
                    .font(.custom("Poppins-Regular", size: 14))
            }
            .foregroundStyle(AppColors.adaptiveText(for: colorScheme).opacity(0.7))
        }
        .padding([.top, .horizontal])
     
    }
}

#Preview {
    PostTitleView(selectedImage: UIImage())
}
