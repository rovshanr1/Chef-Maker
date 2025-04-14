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
    
    //UI-State
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var accountCreated: Bool = false
    
    //Service
    private let authService: AuthServiceProtocol
    
    init(authService: AuthServiceProtocol = AuthService.shared) {
        self.authService = authService
    }
    
    // password secure
    private func isPasswordValid(_ password: String) -> Bool {
        let passwordRegex = #"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).{8,}$"#
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    func createAccount(){
        //TextFields cannot be emty
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty else {
            errorMessage = "All fields are required"
            return
        }
                
        //ConfirmPassword check
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match"
            return
        }
        
        guard isPasswordValid(password) else {
            errorMessage = "Password must be at least 8 characters long and include an uppercase letter, a lowercase letter, a number, and a special character."
            return
        }
        
        Task{
            isLoading = true
            errorMessage = nil
            accountCreated = false
            do {
                try await authService.createAccount(userName: name, email: email, password: password)
                accountCreated = true
            } catch {
                if let authError = error as? AuthError {
                    errorMessage = authError.localizedDescription
                } else {
                    errorMessage = mapFirebaseError(error).localizedDescription
                }
            }
            isLoading = false
        }
    }
}
