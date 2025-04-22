//
//  UserService.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 13.04.25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol UserServiceProtocol {
    func fetchUserProfile(userId: String) async throws -> ProfileModel?
    func saveUserProfile(userId: String, data: ProfileModel) async throws
    func deleteUserProfile(userId: String) async throws
}


class UserService: UserServiceProtocol{
    static let shared = UserService()
    private let db = Firestore.firestore()
    
    func fetchUserProfile(userId: String) async throws -> ProfileModel? {
        let docRef = db.collection("users").document(userId)
        let document = try await docRef.getDocument()
       
        guard let data = document.data(),
              let userName = data["userName"] as? String,
              let email = data["email"] as? String,
              let timestamp = (data["timestamp"] as? Timestamp)?.dateValue()
        else {
            throw NSError(domain: "UserService", code: 0, userInfo: [NSLocalizedDescriptionKey : "Can not parse user document"])
        }
        
        return ProfileModel(
            id: UUID(),
            userName: userName,
            email: email,
            timeStamp: timestamp
        )

            }
    
    func saveUserProfile(userId: String, data: ProfileModel) async throws {
        let docRef = db.collection("users").document(userId)
        try await docRef.setData([
            "userName": data.userName,
            "email": data.email,
            "timestamp": data.timeStamp
        ])
    }
    
    func deleteUserProfile(userId: String) async throws {
        //
    }
}
