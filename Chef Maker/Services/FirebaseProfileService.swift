//
//  FirebaseProfileService.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 01.10.25.
//

import SwiftUI
import FirebaseFirestore


protocol FirestoreRepostory{
    func fetchProfile(for uid: String) async throws -> ProfileModel?
    func updateFullName(for uid: String, fullName: String) async throws
}

final class FirebaseProfileService: FirestoreRepostory{
    private let db: Firestore
    
    init(db: Firestore = Firestore.firestore()) {
        self.db = db
    }
    
    func fetchProfile(for uid: String) async throws -> ProfileModel? {
        let doc = try await db.collection("users").document(uid).getDocument()
        guard let data = doc.data() else { return nil }
        return ProfileModel.fromFirebase(data)
    }
    
    func updateFullName(for uid: String, fullName: String) async throws {
        try await db.collection("users").document(uid).updateData(
            ["fullName": fullName,
             "timeStamp": Date().timeIntervalSince1970
            ])
    }
    
}
