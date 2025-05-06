//
//  ProfileSevice.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 02.05.25.
//

import Foundation
import FirebaseFirestore
//import FirebaseStorage

protocol ProfileServiceProtocol{
   func fetchProfile(for userId: String) async throws -> ProfileModel
    func updateProfile(_ profile: ProfileModel) async throws
    func isUsernameTaken(_ username: String) async throws -> Bool
    func signOut() async throws

//    func uploadProfileImage(_ image: UIImage) async throws -> URL
}

final class ProfileService: ProfileServiceProtocol{
   
    
    private let authService: AuthServiceProtocol
    private let db: Firestore

    init(authService: AuthServiceProtocol = AuthService(),
            db: Firestore = Firestore.firestore()) {
            self.authService = authService
            self.db = db
        }
    
    func fetchProfile(for userId: String) async throws -> ProfileModel {
        let document = try await db.collection("users").document(userId).getDocument()
        
        guard let data = document.data() ,
              let profile = ProfileModel.fromFirebase(data) else {
            throw AuthError.unknown("Profile not found or data is invalid")
        }
        return profile
    }
    
    func updateProfile(_ profile: ProfileModel) async throws {
        try await db.collection("users").document(profile.id).setData(profile.toFirebase(), merge: true)
    }
    
    func isUsernameTaken(_ username: String) async throws -> Bool {
        let doc = try await db.collection("usernames").document(username).getDocument()
        return doc.exists
    }
    
    
    
    func signOut() async throws {
           try await authService.logout()
       }
    
//    func uploadProfileImage(_ image: UIImage) async throws -> URL {
//        print("")
//    }
    
    
}
