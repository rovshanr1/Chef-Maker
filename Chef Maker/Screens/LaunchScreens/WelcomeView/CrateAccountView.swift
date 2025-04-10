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
    
    @State private var isOn = false
    
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
                                .foregroundStyle(AppColors.adaptiveText(for: colorScheme))
                            
                            Text("Let's help you set up your account, it won't take long.")
                                .font(.custom("Poppins-Regular", size: 16))
                                .foregroundStyle(AppColors.adaptiveText(for: colorScheme).opacity(0.7))
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
                                submitLabel: .next
                            )
                            
                            CustomInputField(
                                title: "Confirm Password",
                                placeholder: "Retype Password",
                                text: $createAccountViewModel.password,
                                isSecure: true,
                                textContentType: .password,
                                submitLabel: .done
                            )
                            
                            
                                Toggle(isOn: $isOn){
                                    Text("Terms and Conditions")
                                }
                                .toggleStyle(CheckboxToggleStyle())
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.top, -8)
                                
                         
                            // Create Account Button
                            Button(action: {
                                createAccountViewModel.createAccount()
                            }) {
                                Text("Create Account")
                                    .font(.custom("Poppins-SemiBold", size: 16))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 16)
                                    .background(AppColors.adaptiveAccent(for: colorScheme))
                                    .cornerRadius(12)
                            }
                            .padding(.top, 8)
                            .disabled(!isOn)
                            
                            
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
