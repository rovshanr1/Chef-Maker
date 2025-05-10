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
    func followUser(currentUserID: String, targetUserID: String) async throws
    func unfollowUser(currentUserID: String, targetUserID: String) async throws
//    func followOrUnfollow(targetUserID: String) async
    func signOut() async throws

}

final class ProfileService: ProfileServiceProtocol{
 
   
    
    private let authService: AuthServiceProtocol
    private let db: Firestore

    init(authService: AuthServiceProtocol = AuthService(),
            db: Firestore = Firestore.firestore()) {
            self.authService = authService
            self.db = db
        }
    
    func followUser(currentUserID: String, targetUserID: String) async throws {
        let followersRef = db.collection("followers").document(targetUserID).collection("userFollowers").document(currentUserID)
        let followingRef = db.collection("following").document(currentUserID).collection("userFollowing").document(targetUserID)
        
        try await followersRef.setData(["timestamp": Timestamp()])
        try await followingRef.setData(["timestamp": Timestamp()])
        
        try await incrementFollowCounts(userID: currentUserID, targetID: targetUserID, isFollow: true)

    }
    
    func unfollowUser(currentUserID: String, targetUserID: String) async throws {
        let followersRef = db.collection("followers").document(targetUserID).collection("userFollowers").document(currentUserID)
        let followingRef = db.collection("following").document(currentUserID).collection("userFollowing").document(targetUserID)
        
        try await followersRef.delete()
        try await followingRef.delete()
        
        try await incrementFollowCounts(userID: currentUserID, targetID: targetUserID, isFollow: false)
    }
    
 
    
    private func incrementFollowCounts(userID: String, targetID: String, isFollow: Bool) async throws {
        let currentUserRef = db.collection("users").document(userID)
        let targetUserRef = db.collection("users").document(targetID)

        let increment: Int64 = isFollow ? 1 : -1
        
        try await currentUserRef.updateData([
            "followingCount": FieldValue.increment(increment)
        ])
        
        try await targetUserRef.updateData([
            "followersCount": FieldValue.increment(increment)
        ])
    }
    
    func isFollowing(currentUserID: String, targetUserID: String) async throws -> Bool {
        let docRef = db.collection("following")
            .document(currentUserID)
            .collection("userFollowing")
            .document(targetUserID)
        
        let snapshot = try await docRef.getDocument()
        return snapshot.exists
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
    
}

