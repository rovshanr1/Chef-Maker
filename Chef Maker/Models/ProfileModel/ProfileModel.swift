//
//  ProfileModel.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 13.04.25.
//

import Foundation

struct ProfileModel: Identifiable, Codable {
    let id: String
    var fullName: String
    var userName: String
    var photoURL: String?
    var fileId: String?
    var email: String?
    var bio: String?
    var followingCount: Int
    var followersCount: Int
    var postCount: Int
    var timeStamp: Date
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
    
    static func fromFirebase(_ data: [String: Any]) -> ProfileModel? {
        guard
            let id = data["id"] as? String,
            let fullName = data["fullName"] as? String,
            let userName = data["userName"] as? String
        else { return nil }
        
        return ProfileModel(
            id: id,
            fullName: fullName,
            userName: userName,
            photoURL: data["photoURL"] as? String,
            fileId: data["fileId"] as? String,
            email: data["email"] as? String,
            bio: data["bio"] as? String,
            followingCount: data["followingCount"] as? Int ?? 0,
            followersCount: data["followersCount"] as? Int ?? 0,
            postCount: data["postCount"] as? Int ?? 0,
            timeStamp: (data["timeStamp"] as? TimeInterval).map { Date(timeIntervalSince1970: $0) } ?? Date()
        )
    }
    
    func toFirebase() -> [String: Any] {
        var data: [String: Any] = [
            "id": id,
            "fullName": fullName,
            "userName": userName,
            "timeStamp": timeStamp.timeIntervalSince1970,
            "followersCount": followersCount,
            "followingCount": followingCount,
            "postCount": postCount,
            
        ]
        
        if let fileID = fileId {
            data["fileId"] = fileID
        }
        if let photoURL = photoURL {
            data["photoURL"] = photoURL
        }
        
        if let email = email {
            data["email"] = email
        }
        
        if let bio = bio {
                  data["bio"] = bio
              }
        
        return data
    }
}

#if DEBUG
extension ProfileModel {
    static let preview = ProfileModel(
        id: "user123",
        fullName: "Ayşe Demir",
        userName: "ayse.02",
        photoURL: "https://picsum.photos/200",
        fileId: "",
        email: "ayse.demir@example.com",
        bio: "hi i am a student",
        followingCount: 3,
        followersCount: 2,
        postCount: 4,
        timeStamp: Date()
    )
}
#endif
