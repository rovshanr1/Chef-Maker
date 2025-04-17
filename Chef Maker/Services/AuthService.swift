//
//  AuthService.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 11.04.25.
//

import SwiftUI
import FirebaseAuth

protocol AuthServiceProtocol {
    func login(email: String, password: String) async throws
    func createAccount(userName: String, email: String, password: String) async throws
    func resetPassword(email: String) async throws
}


class AuthService: AuthServiceProtocol{
    static let shared = AuthService()
    
    private let auth = Auth.auth()
    
    // login func
    func login(email: String, password: String) async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            auth.signIn(withEmail: email, password: password) { authResult, error in
                
                if let error = error {
                    continuation.resume(throwing: mapFirebaseError(error))
                    return
                }
                
                guard let user = authResult?.user else{
                    continuation.resume(throwing: AuthError.unknown("An unkown error occured. Please try again"))
                    return
                }
                
                if !user.isEmailVerified {
                    continuation.resume(throwing: AuthError.emailNotVerified)
                    return
                }
                continuation.resume()
            }
        }
    }
    
    // account creation func
    func createAccount(userName: String, email: String, password: String) async throws {
        try await withCheckedThrowingContinuation { (contination: CheckedContinuation<Void, any Error>) in
            auth.createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    contination.resume(throwing: mapFirebaseError(error))
                    return
                }
                guard let user = authResult?.user else {
                    contination.resume(throwing: AuthError.unknown("Internal error occurred"))
                    return
                }
                
                user.sendEmailVerification { error in
                    if let error = error {
                        print("Email verification faild: \(error.localizedDescription)")
                    } else{
                        print("Verification email sent")
                    }
                }

                Task {
                    do {
                        let profile = ProfileModel(
                            id: UUID(),
                            userName: userName,
                            email: email,
                            timeStamp: Date()
                        )
                        try await UserService.shared.saveUserProfile(userId: user.uid, data: profile)
                        contination.resume()
                    } catch {
                        contination.resume(throwing: error)
                    }
                }
            }
        }
    }
    
    // reset password func
    func resetPassword(email: String)  async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, any Error>) in
            auth.sendPasswordReset(withEmail: email) { error in
                if let error = error {
                    continuation.resume(throwing: mapFirebaseError(error))
                } else{
                    continuation.resume()
                }
            }
        }
    }
    
    // logout func
    func logout(appState: AppState) throws {
        do {
            try auth.signOut()
            appState.isLoggedIn = false
        } catch {
            throw AuthError.logoutFailed
        }
    }
}
