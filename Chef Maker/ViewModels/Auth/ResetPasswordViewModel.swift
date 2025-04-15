//
//  ResetPasswordViewModel.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 15.04.25.
//

import Foundation

@MainActor
class ResetPasswordViewModel: ObservableObject{
    @Published var email: String = ""
    @Published var errorMessage: String?
    @Published var isSuccess: Bool = false
    @Published var isLoading: Bool = false
    
    private let authService: AuthServiceProtocol
    
    init(authService: AuthServiceProtocol = AuthService.shared){
        self.authService = authService
    }
    
    func sendLink() {
        errorMessage = nil
        isSuccess = false
        
        guard !email.isEmpty else {
            errorMessage = "Please enter your email"
            return
        }
        
        isLoading = true
        Task{
            do{
                try await authService.resetPassword(email: email)
                isSuccess = true
            }catch{
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
        
        
    }
}
