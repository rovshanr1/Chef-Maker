//
//  CreateAccountViewModel.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 10.04.25.
//

import Foundation

@MainActor
class CreateAccountViewModel: ObservableObject{
    //Input
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var name: String = ""
    @Published var userName: String = ""
    
    //UI-State
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var accountCreated: Bool = false
    
    //Service
    private let profileService: ProfileServiceProtocol
    private let authService: AuthServiceProtocol
    let appState: AppState
    
    
    init(authService: AuthServiceProtocol = AuthService(),
         profileService: ProfileServiceProtocol = ProfileService(),
         appState: AppState
    ) {
        self.authService = authService
        self.profileService = profileService
        self.appState = appState
    }
    
    // password secure
    private func isPasswordValid(_ password: String) -> Bool {
        let passwordRegex = #"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).{8,}$"#
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    func usernameIsValid(_ userName: String) async -> Bool {
        do{
            let result = try await !profileService.isUsernameTaken(userName)
            print("usernameIsValid result: \(result)")
            return result

        }catch{
            print("usernameIsValid error: \(error)")
            return false
        }
    }
    
    
    func createAccount() async -> Bool{
        //TextFields cannot be emty
        
        guard await usernameIsValid(userName) else{
            errorMessage = AuthError.usernameIsTaken.localizedDescription
            return false
        }
        
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty else {
            errorMessage = AuthError.unknown("All fields are required").localizedDescription
            return false
        }
                
        //ConfirmPassword check
//        guard password == confirmPassword else {
//            errorMessage = "Passwords do not match"
//            return false
//        }
        
        guard isPasswordValid(password) else {
            errorMessage = AuthError.weakPassword.localizedDescription
            return false
        }
        
        
            isLoading = true
            errorMessage = nil
            accountCreated = false
            do {
                try await authService.createAccount(fullName: name, userName: userName, email: email, password: password)
                accountCreated = true
                return true
            } catch {
                if let authError = error as? AuthError {
                    errorMessage = authError.localizedDescription
                } else {
                    errorMessage = mapFirebaseError(error).localizedDescription
                }
                return false
            }
        
            
        
    }
}
