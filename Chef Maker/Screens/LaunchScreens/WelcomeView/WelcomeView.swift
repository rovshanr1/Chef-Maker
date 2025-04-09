import SwiftUI

struct WelcomeView: View {
    @StateObject private var loginViewModel = LoginViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    //Navigation State
    @State private var navigateToSignUp: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Group{
                    if colorScheme == .dark {
                        AppColors.darkBackground
                    }else {
                        AppColors.lightBackground
                    }
                }
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
                                placeholder: "Enter Email",
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
                            
                            Button(action: {
                                // Forgot password action
                            }) {
                                Text("Forgot Password?")
                                    .font(.custom("Poppins-Regular", size: 14))
                                    .foregroundColor(AppColors.secondaryColor)
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.top, -8)
                            
                            // Login Button
                            Button(action: {
                                loginViewModel.login()
                            }) {
                                Text("Login")
                                    .font(.custom("Poppins-SemiBold", size: 16))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 16)
                                    .background(AppColors.lightAccent)
                                    .cornerRadius(12)
                            }
                            .padding(.top, 8)
                            
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
            .navigationDestination(isPresented: $navigateToSignUp) {
                CreateAccountView()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    private func socialLoginButton(image: String) -> some View {
        Button(action: {
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
                        .fill(colorScheme == .dark ? Color(UIColor.systemGray6) : .white)
                        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
                )
        }
    }
}

#Preview {
    WelcomeView()
} 
