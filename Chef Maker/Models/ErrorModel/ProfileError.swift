//
//  ProfileError.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 03.05.25.
//

import Foundation


enum ProfileError: LocalizedError {
    
    case invalidEmail
    case invalidPassword
    case invalidConfirmPassword
    case invalidName
    case invalidSurname
    case passwordsDoNotMatch
    case emptyName
    case emptyFields
    case networkError
    case profileNotUpdated
    case emptyUserName
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return "Email is invalid"
        case .invalidPassword:
            return "Password is invalid"
        case .invalidConfirmPassword:
            return "Confirm password is invalid"
        case .invalidName:
            return "Name is invalid"
        case .invalidSurname:
            return "Your surname is invalid "
        case .passwordsDoNotMatch:
            return "Passwords do not match"
        case .emptyFields:
            return "All fields are required"
        case .networkError:
            return "Network error"
        case .profileNotUpdated:
            return "Profile not updated"
        case .unknown(let error):
            return error.localizedDescription
        case .emptyName:
            return "Name is required"
        case .emptyUserName:
            return "Username is required"
        }
    }
}
