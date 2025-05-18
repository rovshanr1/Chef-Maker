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
    func fetchUserPosts(limit: Int?, lastPostId: String?) async throws -> [PostModel]
    func getFollowStatus(currentUser: ProfileModel, targetUser: ProfileModel) async throws -> FollowStatus
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
    
    
    
    func createUserPosts() async throws -> [PostModel] {
        let snapshot = try await db.collection("posts")
            .order(by: "createdAt", descending: true)
            .getDocuments()
        
        var posts: [PostModel] = []
        
        for document in snapshot.documents {
            if let post = PostModel.fromFirebase(document.data()) {
                posts.append(post)
            }
        }
        
        return posts
    }
    
    func fetchUserPosts(limit: Int? = nil, lastPostId: String? = nil) async throws -> [PostModel] {
        var query = db.collection("posts")
            .order(by: "createdAt", descending: true)
        
        
        if let limit = limit {
            query = query.limit(to: limit)
        }
        
        
        if let lastPostId = lastPostId {
            let lastPostDoc = try await db.collection("posts").document(lastPostId).getDocument()
            if let lastPostData = lastPostDoc.data(),
               let lastPost = PostModel.fromFirebase(lastPostData) {
                query = query.whereField("createdAt", isLessThan: lastPost.createdAt)
            }
        }
        
        let snapshot = try await query.getDocuments()
        var posts: [PostModel] = []
        
        for document in snapshot.documents {
            if let post = PostModel.fromFirebase(document.data()) {
                posts.append(post)
            }
        }
        
        return posts
    }
    
    
    func handleFollowAction(action: FollowAction, currentUser: ProfileModel, targetUser: ProfileModel) async throws{
        guard currentUser.id != targetUser.id else {
            throw AuthError.unknown("Users cannot follow themselves")
        }
        
        let batch = db.batch()
        
        let followersRef = db.collection("followers")
            .document(targetUser.id)
            .collection("userFollowers")
            .document(currentUser.id)
        
        let followingRef = db.collection("following")
            .document(currentUser.id)
            .collection("userFollowing")
            .document(targetUser.id)
        
        let targetUserRef = db.collection("users").document(targetUser.id)
        let currentUserRef = db.collection("users").document(currentUser.id)
        
        switch action {
        case .follow:
            batch.setData([
                "timestamp": Timestamp(),
                "status": "active",
                "followerName": currentUser.fullName,
                "followerUsername": currentUser.userName
            ], forDocument: followersRef)
            
            batch.setData([
                "timestamp": Timestamp(),
                "status": "active",
                "followingName": targetUser.fullName,
                "followingUsername": targetUser.userName
            ], forDocument: followingRef)
            
            batch.updateData([
                "followersCount": FieldValue.increment(Int64(1))
            ], forDocument: targetUserRef)
            
            batch.updateData([
                "followingCount": FieldValue.increment(Int64(1))
            ], forDocument: currentUserRef)
            
        case .unfollow:
            batch.deleteDocument(followersRef)
            batch.deleteDocument(followingRef)
            
            batch.updateData([
                "followersCount": FieldValue.increment(Int64(-1))
            ], forDocument: targetUserRef)
            
            batch.updateData([
                "followingCount": FieldValue.increment(Int64(-1))
            ], forDocument: currentUserRef)
        }
        
        try await batch.commit()
    }
    
    func getFollowStatus(currentUser: ProfileModel, targetUser: ProfileModel) async throws -> FollowStatus {
        let docRef = db.collection("following")
            .document(currentUser.id)
            .collection("userFollowing")
            .document(targetUser.id)
        
        let snapshot = try await docRef.getDocument()
        
        guard let data = snapshot.data() else {
            return FollowStatus(isFollowing: false, timeStamp: nil, status: nil)
        }
        
        let timestamp = (data["timestamp"] as? Timestamp)?.dateValue()
        let status = data["status"] as? String
        
        return FollowStatus(
            isFollowing: snapshot.exists && status == "active",
            timeStamp: timestamp,
            status: status
        )
    }
    
    func getFollowers(for user: ProfileModel) async throws -> [ProfileModel] {
        let snapshot = try await db.collection("followers")
            .document(user.id)
            .collection("userFollowers")
            .getDocuments()
        
        var followers: [ProfileModel] = []
        
        for document in snapshot.documents {
             let followerId = document.documentID
            let follower = try await fetchProfile(for: followerId)
            followers.append(follower)
            
        }
        
        return followers
    }
    
    func getFollowing(for user: ProfileModel) async throws -> [ProfileModel] {
        let snapshot = try await db.collection("following")
            .document(user.id)
            .collection("userFollowing")
            .getDocuments()
        
        var following: [ProfileModel] = []
        
        for document in snapshot.documents {
             let followingId = document.documentID
            let followingUser = try await fetchProfile(for: followingId)
            following.append(followingUser)
            
        }
        
        return following
    }

    
    func isFollowing(currentUserID: String, targetUserID: String) async throws -> Bool {
        let docRef = db.collection("following")
            .document(currentUserID)
            .collection("userFollowing")
            .document(targetUserID)
        
        let snapshot = try await docRef.getDocument()
        return snapshot.exists && (snapshot.data()?["status"] as? String == "active")
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

