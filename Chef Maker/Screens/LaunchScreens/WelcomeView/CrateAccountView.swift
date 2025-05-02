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
    @State private var navigateToWelcomeScreen = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.adaptiveBackground(for: colorScheme)
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
                                title: "User Name",
                                placeholder: "Add Your Individual Username",
                                text: $createAccountViewModel.userName,
                                keyboardType: .default,
                                textContentType: .username,
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
                            
                            
                                Toggle("I agree to the terms and conditions", isOn: $isOn)
                                .font(.custom("Poppins-Medium", size: 14))
                                .foregroundStyle(.secondary)
                                .toggleStyle(CheckboxToggleStyle())
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.top, -8)
                                
                         
                            // Create Account Button
                            Button(action: {
                                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                
                                Task{
                                 let succes = await createAccountViewModel.createAccount()
                                    if succes{
                                        createAccountViewModel.accountCreated = true
                                    }
                                }
                            }) {
                                if createAccountViewModel.isLoading{
                                    ProgressView()
                                        .progressViewStyle(.circular)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 16)
                                }else{
                                    Text("Sign Up")
                                        .font(.custom("Poppins-SemiBold", size: 16))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 16)
                                }
                            }
                            .background(AppColors.adaptiveAccent(for: colorScheme))
                            .cornerRadius(12)
                            .disabled(!isOn || createAccountViewModel.isLoading)
                            
                            
                            HStack{
                                Text("Already a member?")
                                    .font(.custom("Poppins-Regular", size: 14))
                                    .foregroundStyle(.secondary)
                                Button(action: {
                                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                    navigateToWelcomeScreen = true
                                }){
                                   Text("Sign in")
                                        .font(.custom("Poppins-SemiBold", size: 14))
                                        .foregroundColor(AppColors.secondaryColor)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 32)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 40)
                }
                .onTapGesture {
                    hideKeyboard()
                }
            }
            .navigationDestination(isPresented: $navigateToWelcomeScreen, destination: {
                WelcomeView()
            })
            .navigationDestination(isPresented: $createAccountViewModel.accountCreated, destination: {
                WelcomeView()
            })
            .navigationBarBackButtonHidden(true)
        }
        .alert(isPresented: Binding<Bool>(
            get: {createAccountViewModel.errorMessage != nil},
            set: {_ in createAccountViewModel.errorMessage = nil}
        )){
            Alert(
                title: Text("Opps"),
                message: Text(createAccountViewModel.errorMessage ?? ""),
                dismissButton: .default(Text("Ok"))
            )
        }
    }
    
}

#Preview {
    CreateAccountView()
        .preferredColorScheme(.dark)
}
