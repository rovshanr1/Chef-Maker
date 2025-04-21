import SwiftUI

struct WelcomeView: View {
    @StateObject private var loginViewModel = LoginViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    //Navigation State
    @State private var navigateToSignUp: Bool = false
    @State private var navigateToForgotPassword: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.adaptiveBackground(for: colorScheme)
                .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 52) {
                        // Header Section
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Hello,")
                                .font(.custom("Poppins-Bold", size: 32))
                                .foregroundStyle(colorScheme == .dark ? .white : AppColors.lightText)
                            
                            Text("Welcome Back!")
                                .font(.custom("Poppins-Regular", size: 20))
                                .foregroundStyle(colorScheme == .dark ? .white.opacity(0.7) : AppColors.lightText.opacity(0.8))
                        }
                        
                        // Login Form Section
                        VStack(alignment: .leading, spacing: 24) {
                            CustomInputField(
                                title: "Email",
                                placeholder: "Enter Your Email",
                                text: $loginViewModel.email,
                                keyboardType: .emailAddress,
                                textContentType: .emailAddress,
                                submitLabel: .next
                            )
                            
                            CustomInputField(
                                title: "Password",
                                placeholder: "Enter Password",
                                text: $loginViewModel.password,
                                isSecure: true,
                                textContentType: .password,
                                submitLabel: .done
                            )
                            
                            // Forgot password button
                            Button(action: {
                                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                navigateToForgotPassword = true
                                
                            }) {
                                Text("Forgot Password?")
                                    .font(.custom("Poppins-Regular", size: 14))
                                    .foregroundColor(AppColors.secondaryColor)
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.top, -8)
                            .sheet(isPresented: $navigateToForgotPassword){
                                ResetPasswordView()
                            }
                            
                            // Login button
                            Button(action: {
                                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                loginViewModel.login()
                            }) {
                                if loginViewModel.isLoading{
                                    ProgressView()
                                        .progressViewStyle(.circular)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 16)
                                } else{
                                    HStack{
                                        Text("Login")
                                            .font(.custom("Poppins-SemiBold", size: 16))
                                          
                                        Image(systemName: "arrow.right")
                                    }
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 16)
                                }
                            }
                            .background(AppColors.lightAccent)
                            .cornerRadius(12)
                            .disabled(loginViewModel.isLoading)
                            
                            // Divider with Text
                            HStack {
                                Rectangle()
                                    .fill(colorScheme == .dark ? Color.white.opacity(0.2) : Color.gray.opacity(0.3))
                                    .frame(height: 1)
                                
                                Text("or login with")
                                    .font(.custom("Poppins-Regular", size: 14))
                                    .foregroundStyle(colorScheme == .dark ? .white.opacity(0.7) : AppColors.lightText.opacity(0.8))
                                
                                Rectangle()
                                    .fill(colorScheme == .dark ? Color.white.opacity(0.2) : Color.gray.opacity(0.3))
                                    .frame(height: 1)
                            }
                            .padding(.vertical, 16)
                            
                            // Social Login Buttons
                            HStack(spacing: 25) {
                                socialLoginButton(image: "google_logo")
                                socialLoginButton(image: "apple_logo")
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            
                            // Sign Up Section
                            HStack {
                                Text("Don't have an account?")
                                    .font(.custom("Poppins-Regular", size: 14))
                                    .foregroundStyle(colorScheme == .dark ? .white.opacity(0.7) : AppColors.lightText.opacity(0.8))
                                Button(action: {
                                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                    navigateToSignUp = true
                                    
                                }) {
                                    Text("Sign Up")
                                        .font(.custom("Poppins-SemiBold", size: 14))
                                        .foregroundColor(AppColors.secondaryColor)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 32)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 60)
                }
                .onTapGesture {
                    hideKeyboard()
                }
            }
            .navigationDestination(isPresented: $loginViewModel.isLogedIn, destination: {
                //DiscoveryView()
            })
            .navigationDestination(isPresented: $navigateToSignUp) {
                    CreateAccountView()
            }
            .navigationBarBackButtonHidden(true)
        }
        .alert(isPresented: Binding<Bool>(
            get: { loginViewModel.errorMessage != nil },
            set: {_ in loginViewModel.errorMessage = nil}
        )) {
            Alert(
                title: Text("Error"),
                message: Text(loginViewModel.errorMessage ?? ""),
                dismissButton: .default(Text("OK")))
        }
    }
    
    private func socialLoginButton(image: String) -> some View {
        Button(action: {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            // Social login action
        }) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .padding()
                .frame(width: 64, height: 64)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(colorScheme == .dark
                              ? Color(AppColors.darkCardBackground.opacity(1.0)) : Color(AppColors.lightBackground.opacity(1.0)))
                        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                )
        }
    }
}

#Preview {
    WelcomeView()
} 
