//
//  AuthService.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 11.04.25.
//

import Foundation
import FirebaseAuth

protocol AuthServiceProtocol {
    func logIn(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func createAccount(userName: String, email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
}


class AuthService: AuthServiceProtocol{
    static let shared = AuthService()
    
    func logIn(email: String, password: String, completion: @escaping (Result<Void, any Error>) -> Void) {
        <#code#>
    }
    
    func createAccount(userName: String, email: String, password: String, completion: @escaping (Result<Void, any Error>) -> Void) {
        
    }
}
