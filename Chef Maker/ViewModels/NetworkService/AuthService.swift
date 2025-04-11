//
//  AuthService.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 11.04.25.
//

import Foundation
import FirebaseAuth

protocol AuthServiceProtocol {
    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func createAccount(userName: String, email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
}


class AuthService: AuthServiceProtocol{
    static let shared = AuthService()
    
    func login(email: String, password: String, completion: @escaping (Result<Void, any Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password ){ authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let user = authResult?.user, !user.isEmailVerified{
                completion(.failure(NSError(domain: "AuthError",
                                            code: 1001,
                                            userInfo: [NSLocalizedDescriptionKey : "Please verify your email"])))
                return
            }
            completion(.success(()))
        }
    }
    
    func createAccount(userName: String, email: String, password: String, completion: @escaping (Result<Void, any Error>) -> Void) {
        
    }
}
