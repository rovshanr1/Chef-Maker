import SwiftUI

struct WelcomeView: View {
    @StateObject private var loginViewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack{
            ZStack {
                ScrollView{
                    VStack(alignment: .leading, spacing: 52) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Hello,")
                                .font(.custom("Poppins-Bold", size: 32))
                                .foregroundColor(AppColors.lightText)
                            
                            Text("Welcome Back!")
                                .font(.custom("Poppins-Regular", size: 20))
                                .foregroundColor(AppColors.lightText.opacity(0.8))
                        }
                        
                        VStack(alignment: .leading, spacing: 24) {
                            CustomInputField(
                                title: "Email",
                                placeholder: "Enter Email",
                                text: $loginViewModel.email,
                                keyboardType: .emailAddress
                            )
                            
                            CustomInputField(
                                title: "Password",
                                placeholder: "Enter Password",
                                text: $loginViewModel.password,
                                isSecure: true
                            )
                            
                            
                            Button(action: {
                                
                            }) {
                                Text("Forgot Password?")
                                    .font(.custom("Poppins-Regular", size: 14))
                                    .foregroundColor(AppColors.secondaryColor)
                            }
                            .padding(.bottom)
                          
                            
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
                            
                            HStack{
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(height: 1)
                                
                                Text("or login with")
                                    .font(.custom("Poppins-Regular", size: 14))
                                    .foregroundColor(AppColors.lightText.opacity(0.8))
                                
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(height: 1)
                            }
                            .padding(.horizontal, 24)
                            
                            VStack(spacing: 52) {
                                HStack(spacing: 25){
                                    Button(action:{
                                        
                                    }){
                                        Image("google_logo")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 33)
                                            .padding()
                                            .background( RoundedRectangle(cornerRadius: 8)
                                                .fill(Color.white)
                                                .shadow(radius: 1))
                                           
                                        
                                    }
                                    Button(action:{
                                        
                                    }){
                                        Image("apple_logo")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 33)
                                            .padding()
                                            .background( RoundedRectangle(cornerRadius: 8)
                                                .fill(Color(.white))
                                                .shadow(radius: 1)
                                            )
                                            
                                    }
                                }
                                HStack {
                                    Text("Don't have an account?")
                                        .font(.custom("Poppins-Regular", size: 14))
                                        .foregroundColor(AppColors.lightText.opacity(0.8))
                                    
                                    Button(action: {
                                        
                                    }) {
                                        Text("Sign Up")
                                            .font(.custom("Poppins-SemiBold", size: 14))
                                            .foregroundColor(AppColors.secondaryColor)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                            }
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
            .navigationBarBackButtonHidden(true)
        }
    }
}





#Preview {
    WelcomeView()
} 
