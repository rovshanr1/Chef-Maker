//
//  AuthService.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 11.04.25.
//

import Foundation
import FirebaseAuth

protocol AuthServiceProtocol {
    func login(email: String, password: String) async throws
    func createAccount(userName: String, email: String, password: String) async throws
    func resetPassword(email: String) async throws
}


class AuthService: AuthServiceProtocol{
    static let shared = AuthService()
    
    private let auth = Auth.auth()
    
    func login(email: String, password: String) async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
               auth.signIn(withEmail: email, password: password) { authResult, error in
                   if let error = error {
                       continuation.resume(throwing: error)
                       return
                   }
                   
                   guard let user = authResult?.user else{
                       continuation.resume(throwing: AuthError.unknown("An unkown error occured. Please try again"))
                   }
                   
                   if !user.isEmailVerified {
                       continuation.resume(throwing: AuthError.unknown("Email not verified"))
                   }
                   continuation.resume()
               }
           }
       }
    
    func createAccount(userName: String, email: String, password: String) async throws {
        try await withCheckedThrowingContinuation { (contination: CheckedContinuation<Void, any Error>) in
            <#code#>
        }
    }
    
    func resetPassword(email: String) async throws {
        <#code#>
    }
    
   
    
    func loginn(email: String, password: String, completion: @escaping (Result<Void, any Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password ){ authResult, error in
            if let error = error {
                let mappedError = mapFirebaseError(error)
                completion(.failure(mappedError))
                return
            }
            if let user = authResult?.user, !user.isEmailVerified{
                completion(.failure(AuthError.emailNotVerified))
                return
            }
            completion(.success(()))
        }
    }
    
    func createAccount(userName: String, email: String, password: String, completion: @escaping (Result<Void, any Error>) -> Void) {
        guard !userName.isEmpty else {
            completion(.failure(AuthError.userNameCanNotBeEmpty))
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard self != nil else {
                completion(.failure(AuthError.unknown("Internal error occurred")))
                return
            }
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let user = authResult?.user else {
                completion(.failure(AuthError.unknown("Internal error occurred")))
                return
            }
            
            user.sendEmailVerification { error in
                if let error = error {
                    print("Sending verification email...\(error.localizedDescription)")
                }
            }
        }
        
        func resetPassword(email: String) {
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let error = error {
                    print("Sending password reset email...\(error.localizedDescription)")
                } else {
                    print("A password reset email has been sent to your email address.")
                }
            }
            
            UserService.shared.saveUserProfile{_ in 
                
            }
        }
    }
    
    
}
