//
//  SessionManager.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 02.10.25.
//

import Foundation
import FirebaseAuth

protocol SessionManaging{
    var isLoggedIn: Bool { get }
    var currenUser: User? { get }
    
    func checkSession() async -> Bool
    func getIdTokken() async throws -> String
    func loginSucceded() async
    func logout() async throws
}

final class SessionManager: SessionManaging, ObservableObject{
    private let authService: AuthServiceProtocol
    private let auth = Auth.auth()
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    
    var isLoggedIn: Bool{
        authService.currentUser != nil
    }
    
    var currenUser: User?{
        authService.currentUser
    }
    
    func getIdTokken() async throws -> String {
        guard let user = auth.currentUser else {
            throw AuthError.unknown("Current user not found")
        }
        return try await withCheckedThrowingContinuation { continuation in
            user.getIDToken { token, error in
                if let token = token {
                    continuation.resume(returning: token)
                } else {
                    continuation.resume(throwing: error ?? AuthError.unknown("Token alınamadı"))
                }
            }
        }
    }
    
    func checkSession() async -> Bool {
       await authService.checkSession()
    }
    
    func loginSucceded() async {
        
    }
    
    func logout() async throws {
        try await authService.logout()
    }
}
