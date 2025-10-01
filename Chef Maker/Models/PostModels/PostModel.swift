//
//  PostModel.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 07.05.25.
//

import Foundation


//MARK: - Post Model
struct PostModel: Identifiable, Codable {
    let id: String
    let title: String
    let description: String
    
    let postImage: String?
    
    let ingredients: [SelectedIngredient]
    let cookingTime: String
    let serving: String
    let category: String
    let difficulty: String
    let nutrients: String
    
    let authorId: String
    let createdAt: Date
    
    var likes: Int
    var comments: Int
    var saves: Int
    
    var isLiked: Bool?
    var isSaved: Bool?
}

//MARK: - Selected IngredientModel
struct SelectedIngredient: Identifiable, Codable {
    var id: String
    var name: String
    var quantity: String
    var unit: String
}


//MARK: - Post Model Extension
extension PostModel {
    static func fromFirebase(_ data: [String: Any]) -> PostModel? {
        guard let id = data["id"] as? String,
              let title = data["title"] as? String,
              let description = data["description"] as? String,
              let cookingTime = data["cookingTime"] as? String,
              let serving = data["serving"] as? String,
              let category = data["category"] as? String,
              let difficulty = data["difficulty"] as? String,
              let nutrients = data["nutrients"] as? String,
              let authorId = data["authorId"] as? String,
              let createdAt = data["createdAt"] as? TimeInterval
        else { return nil }
        
        
        guard let ingredientDicts = data["ingredients"] as? [[String: Any]] else {
            return nil
        }

        let ingredients = ingredientDicts.compactMap { dict -> SelectedIngredient? in
            guard let id = dict["id"] as? String,
                  let name = dict["name"] as? String,
                  let quantity = dict["quantity"] as? String,
                  let unit = dict["unit"] as? String else {
                return nil
            }
            return SelectedIngredient(id: id, name: name, quantity: quantity, unit: unit)
        }

        return PostModel(
            id: id,
            title: title,
            description: description,
            postImage: data["postImage"] as? String,
            ingredients: ingredients,
            cookingTime: cookingTime,
            serving: serving,
            category: category,
            difficulty: difficulty,
            nutrients: nutrients,
            authorId: authorId,
            createdAt: Date(timeIntervalSince1970: createdAt),
            likes: data["likes"] as? Int ?? 0,
            comments: data["comments"] as? Int ?? 0,
            saves: data["saves"] as? Int ?? 0,
            isLiked: data["isLiked"] as? Bool,
            isSaved: data["isSaved"] as? Bool
        )
    }
    
    func toFirebase() -> [String: Any] {
        var data: [String: Any] = [
            "id": id,
            "title": title,
            "description": description,
            "ingredients": ingredients.map { [
                "id": $0.id,
                "name": $0.name,
                "quantity": $0.quantity,
                "unit": $0.unit
            ] },
            "cookingTime": cookingTime,
            "serving": serving,
            "category": category,
            "difficulty": difficulty,
            "nutrients": nutrients,
            "authorId": authorId,
            "createdAt": createdAt.timeIntervalSince1970,
            "likes": likes,
            "comments": comments,
            "saves": saves
        ]
        
        if let postImage = postImage {
            data["postImage"] = postImage
        }
        
        if let isLiked = isLiked {
            data["isLiked"] = isLiked
        }
        
        if let isSaved = isSaved {
            data["isSaved"] = isSaved
        }
        
        return data
    }
}

//MARK: - for Mock Data
#if DEBUG
extension PostModel {
    static let previews = PostModel(
        id: "post001",
        title: "Creamy Mushroom Pasta",
        description: "A delicious homemade lasagna with layers!",
        postImage: "https://spoonacular.com/recipeImages/579247-556x370.jpg",
        ingredients: [
            SelectedIngredient(id: "1", name: "Mushrooms", quantity: "200", unit: "g"),
            SelectedIngredient(id: "2", name: "Pasta", quantity: "250", unit: "g"),
            SelectedIngredient(id: "3", name: "Cream", quantity: "100", unit: "ml")
        ],
        cookingTime: "45 m",
        serving: "6",
        category: "Akşam Yemeği",
        difficulty: "Medium",
        nutrients: "500 kcal",
        authorId: "user123",
        createdAt: Date(),
        likes: 0,
        comments: 0,
        saves: 0,
        isLiked: false,
        isSaved: false
    )
    
}
#endif
