//
//  CustomTexteditorField.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 28.05.25.
//

import SwiftUI

struct CustomTexteditorField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    @Environment(\.colorScheme) var colorScheme 
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .font(.custom("Poppins-Medium", size: 14))
                .foregroundStyle(AppColors.adaptiveText(for: colorScheme).opacity(0.6))
            
            ZStack(alignment: .topLeading) {

                TextEditor(text: $text)
                    .foregroundStyle(.gray)
                    .scrollContentBackground(.hidden)
                    .frame(height: 140)
                    .padding(10)
                    .background(Color.appsBackground)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(AppColors.adaptiveText(for: colorScheme).opacity(0.2), lineWidth: 1)
                    )
                    .font(.custom("Poppins-Regular", size: 14))
                
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.gray.opacity(0.6))
                        .padding(.horizontal, 14)
                        .padding(.vertical, 16)
                       
                }
   
            }
            .onAppear(){
                UITextView.appearance().backgroundColor = .clear
            }
            .onDisappear(){
                UITextView.appearance().backgroundColor = nil
            }
        }
    }
}



//#Preview {
// PostTitleView(appState: AppState(), selectedImage: UIImage())
//        .environmentObject(AppState())
//}
