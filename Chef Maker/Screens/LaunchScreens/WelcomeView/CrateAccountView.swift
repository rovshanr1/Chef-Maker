//
//  CrateAccountView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 09.04.25.
//

import SwiftUI

struct CreateAccountView: View {
    @StateObject private var createAccountViewModel = CreateAccountViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            ZStack {
                Group {
                    if colorScheme == .dark {
                        AppColors.darkBackground
                    }else{
                        AppColors.lightBackground
                    }
                }
                .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 32) {
                        // Header Section
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Create an account")
                                .font(.custom("Poppins-Bold", size: 28))
                                .foregroundStyle(AppColors.adaptiveText)
                            
                            Text("Let's help you set up your account, it won't take long.")
                                .font(.custom("Poppins-Regular", size: 16))
                                .foregroundStyle(AppColors.adaptiveText.opacity(0.7))
                                .lineLimit(2)
                        }
                        
                        // Form Section
                        VStack(alignment: .leading, spacing: 24) {
                            CustomInputField(
                                title: "Name",
                                placeholder: "Add your name",
                                text: $createAccountViewModel.name,
                                keyboardType: .default,
                                textContentType: .name,
                                submitLabel: .next
                            )
                            
                            CustomInputField(
                                title: "Email",
                                placeholder: "Enter Your Email",
                                text: $createAccountViewModel.email,
                                keyboardType: .emailAddress,
                                textContentType: .emailAddress,
                                submitLabel: .next
                            )
                            
                            CustomInputField(
                                title: "Password",
                                placeholder: "Create Password",
                                text: $createAccountViewModel.password,
                                isSecure: true,
                                textContentType: .newPassword,
                                submitLabel: .done
                            )
                            
                            // Create Account Button
                            Button(action: {
//                                createAccountViewModel.createAccount()
                            }) {
                                Text("Create Account")
                                    .font(.custom("Poppins-SemiBold", size: 16))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 16)
                                    .background(AppColors.adaptiveAccent)
                                    .cornerRadius(12)
                            }
                            .padding(.top, 8)
                            
                            
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 40)
                }
                .onTapGesture {
                    hideKeyboard()
                }
            }
        }
    }
}

#Preview {
    CreateAccountView()
        .preferredColorScheme(.dark)
}
