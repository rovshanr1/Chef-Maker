//
//  AuthError.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 11.04.25.
//

import Foundation
import FirebaseAuth

enum AuthError: LocalizedError {
    case emailNotVerified
    case wrongPassword
    case userNotFound
    case emailAlreadyInUse
    case weakPassword
    case networkError
    case userNameCanNotBeEmpty
    case invalidEmail
    case logoutFailed
    case tokenRefreshFailed
    case usernameIsTaken
    case unknown(String)

    var errorDescription: String? {
        switch self {
        case .emailNotVerified:
            return "Please verify your email before signing in."
        case .wrongPassword:
            return "The password you entered is incorrect."
        case .userNotFound:
            return "No account found with this email."
        case .emailAlreadyInUse:
            return "This email is already in use."
        case .weakPassword:
            return "Password must be at least 8 characters long and include an uppercase letter, a lowercase letter, a number, and a special character."
        case .networkError:
            return "Check your internet connection and try again."
        case .userNameCanNotBeEmpty:
            return "Username can not be empty"
        case .invalidEmail:
            return "The email address is badly formatted"
        case .logoutFailed:
            return "Logout failed"
        case .tokenRefreshFailed:
            return "Token refresh failed"
        case .usernameIsTaken:
            return "This username is already taken. Please choose another one."
        case .unknown(let message):
            return message
       
      
        }
    }
}

func mapFirebaseError(_ error: Error) -> AuthError {
    let nsError = error as NSError
    
    guard let errorCode = AuthErrorCode(rawValue: nsError.code) else {
        return .unknown(error.localizedDescription)
    }

    switch errorCode {
    case .wrongPassword:
        return .wrongPassword
    case .userNotFound:
        return .userNotFound
    case .weakPassword:
        return .weakPassword
    case .networkError:
        return .networkError
    case .invalidEmail:
        return .invalidEmail
    case .emailAlreadyInUse:
        return .emailAlreadyInUse
    case .userTokenExpired:
        return .tokenRefreshFailed
    default:
        return .unknown(error.localizedDescription)
    }
}
