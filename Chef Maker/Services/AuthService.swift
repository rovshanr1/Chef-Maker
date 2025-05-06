//
//  AuthService.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 11.04.25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

protocol AuthServiceProtocol {
    var currentUser: User? { get }
    func login(email: String, password: String) async throws
    func createAccount(fullName: String, userName: String, email: String, password: String) async throws
    func isUsernameTaken(_ username: String) async throws -> Bool
    func resetPassword(email: String) async throws
    func logout() async throws
    
    func checkSession() async -> Bool
}


class AuthService: AuthServiceProtocol{
    
    private  let auth = Auth.auth()
    private let db = Firestore.firestore()
    
    var currentUser: User? {
        auth.currentUser
    }
    
    init() {}
    
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
    func createAccount(fullName: String, userName: String, email: String, password: String) async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, any Error>) in
            auth.createUser(withEmail: email, password: password) { [self] authResult, error in
                if let error = error {
                    continuation.resume(throwing: mapFirebaseError(error))
                    return
                }
                guard let user = authResult?.user else {
                    continuation.resume(throwing: AuthError.unknown("Internal error occurred"))
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
                            id: user.uid,
                            fullName: fullName,
                            userName: userName,
                            photoURL: "",
                            fileId: "",
                            email: email,
                            bio: "",
                            followingCount: 0,
                            followersCount: 0,
                            postCount: 0,
                            timeStamp: Date()
                        )
                        try await db.collection("users").document(user.uid).setData(profile.toFirebase())
                        continuation.resume()
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
    
    func isUsernameTaken(_ username: String) async throws -> Bool {
        let doc = try await db.collection("usernames").document(username).getDocument()
        return doc.exists
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
    func logout() async throws {
        do {
            try auth.signOut()
        } catch {
            throw AuthError.logoutFailed
        }
    }
    
    func checkSession() async -> Bool {
        guard let user = currentUser else {
            return false
        }
        
        guard user.isEmailVerified else {
            return false
        }
        
        return true
    }
    
}
