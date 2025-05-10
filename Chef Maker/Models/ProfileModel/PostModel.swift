//
//  PostModel.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 07.05.25.
//

import Foundation

struct PostModel: Identifiable, Codable {
    var id: String
    var title: String
    var postImage: String?
    var description: String
    var ingredients: [String]
    var cookingTime: String
    var category: String
    var difficulty: String
    var nutrients: String
    
    var authorId: String
    var createdAt: Date
    
}


extension PostModel {
    static func fromFirebase(_ data: [String: Any]) -> PostModel? {
        guard let id = data["id"] as? String,
              let title = data["title"] as? String,
              let description = data["description"] as? String,
              let ingredients = data["ingredients"] as? [String],
              let cookingTime = data["cookingTime"] as? String,
              let category = data["category"] as? String,
              let difficulty = data["difficulty"] as? String,
              let nutrients = data["nutrients"] as? String,
              let authorId = data["authorId"] as? String,
              let createdAt = data["createdAt"] as? TimeInterval
        else { return nil }

        return PostModel(
            id: id,
            title: title,
            postImage: data["postImage"] as? String,
            description: description,
            ingredients: ingredients,
            cookingTime: cookingTime,
            category: category,
            difficulty: difficulty,
            nutrients: nutrients,
            authorId: authorId,
            createdAt: Date(timeIntervalSince1970: createdAt)
        )
    }

    func toFirebase() -> [String: Any] {
        var data: [String: Any] = [
            "id": id,
            "title": title,
            "description": description,
            "ingredients": ingredients,
            "cookingTime": cookingTime,
            "category": category,
            "difficulty": difficulty,
            "nutrients": nutrients,
            "authorId": authorId,
            "createdAt": createdAt.timeIntervalSince1970
        ]

        if let postImage = postImage {
            data["postImage"] = postImage
        }

        return data
    }
}


#if DEBUG
extension PostModel {
    static let previews = PostModel (
        id: "post001",
              title: "Nefis Lazanya",
              postImage: "https://picsum.photos/300",
              description: "Kat kat nefis bir ev yapımı lazanya!",
              ingredients: ["Domates", "Kıyma", "Soğan", "Lazanya hamuru"],
              cookingTime: "45 dk",
              category: "Akşam Yemeği",
              difficulty: "Orta",
              nutrients: "500 kcal",
              authorId: "user123",
              createdAt: Date()
    )
}
#endif
