//
//  ResetPasswordView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 15.04.25.
//

import SwiftUI

struct ResetPasswordView: View {
    @StateObject private var viewModel = ResetPasswordViewModel()
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    

    
    var body: some View {
        ZStack{
            AppColors.adaptiveBackground(for: colorScheme)
                .ignoresSafeArea()
            
            
            VStack(spacing: 24){
                Button(action: {
                        dismiss()
                }){
                    Image(systemName: "xmark")
                        .font(.body.weight(.bold))
                        .foregroundStyle(AppColors.adaptiveText(for: colorScheme).opacity(0.4))
                        .padding(8)
                        .background(
                            Circle()
                                .fill(colorScheme == .dark
                                      ? Color(AppColors.darkCardBackground.opacity(0.9)) : Color(AppColors.lightBackground.opacity(0.9)))
                                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                        )
                }
                .frame(maxWidth: .infinity, alignment: .topTrailing)
                
                    // Header Section
                    VStack(spacing: 8) {
                        Text("Reset Password")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(AppColors.adaptiveText(for: colorScheme))
                        
                        Divider()
                            .background(Color.gray.opacity(0.3))
                            .padding(.horizontal, -24)
                    }
                    
                    // Description
                    Text("Enter your email address and we'll send you a link to reset your password.")
                        .font(.custom("Poppins-Regular", size: 16))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                
                CustomInputField(
                    title: "Reset Password",
                    placeholder: "Enter your email",
                    text: $viewModel.email,
                    keyboardType: .emailAddress,
                    textContentType: .emailAddress,
                    submitLabel: .done
                    )
            
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .font(.footnote)
                        .foregroundStyle(.red)
                }
                
                if viewModel.isSuccess {
                    Text("Reset link has been sent to your email.")
                        .font(.footnote)
                        .foregroundStyle(.green)
                }
                
                Button(action:{
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    viewModel.sendLink()
                }){
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                    }else {
                        Text("Send Reset Link")
                            .font(.custom("Poppins-SemiBold", size: 16))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                    }
                    
                }
                .background(AppColors.adaptiveAccent(for: colorScheme))
                .cornerRadius(12)
                .padding(.top, 16)
            }
            .padding(24)
        }
        .presentationDetents([.height(400)])
        .onTapGesture { hideKeyboard() }
       
    }
}

#Preview {
    ResetPasswordView()
}
