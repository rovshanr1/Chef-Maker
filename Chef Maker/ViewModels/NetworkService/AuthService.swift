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
        }
    }
}
