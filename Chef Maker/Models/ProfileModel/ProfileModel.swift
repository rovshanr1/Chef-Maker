//
//  ProfileModel.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 13.04.25.
//

import Foundation

struct ProfileModel: Identifiable, Codable {
    let id: String
    let fullName: String
    var photoURL: String?
    var email: String?
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
            let fullName = data["fullName"] as? String
        else { return nil }
        
        return ProfileModel(
            id: id,
            fullName: fullName,
            photoURL: data["photoURL"] as? String,
            email: data["email"] as? String,
            timeStamp: (data["timeStamp"] as? TimeInterval).map { Date(timeIntervalSince1970: $0) } ?? Date()
        )
    }
    
    func toFirebase() -> [String: Any] {
        var data: [String: Any] = [
            "id": id,
            "fullName": fullName,
            "timeStamp": timeStamp.timeIntervalSince1970
        ]
        
        if let photoURL = photoURL {
            data["photoURL"] = photoURL
        }
        
        if let email = email {
            data["email"] = email
        }
        
        return data
    }
}

#if DEBUG
extension ProfileModel {
    static let preview = ProfileModel(
        id: "user123",
        fullName: "Ayşe Demir",
        photoURL: "https://picsum.photos/200",
        email: "ayse.demir@example.com",
        timeStamp: Date()
    )
}
#endif
