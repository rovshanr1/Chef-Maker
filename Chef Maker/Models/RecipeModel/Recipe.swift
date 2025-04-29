import Foundation


struct SpoonacularResponse: Codable {
    let results: [Recipe]
    let offset: Int
    let number: Int
    let totalResults: Int
}


struct Recipe: Codable, Identifiable {
    let id: Int
    let title: String
    let image: String
    let readyInMinutes: Int
    let imageType: String
    let aggregateLikes: Int
    let spoonacularScore: Double?
    let nutrition: RecipeNutrition

    
    var cookTime: Int {
        readyInMinutes
    }
    
    var likesCount: Int {
        aggregateLikes
    }
    
    
    var starRating: Int {
        Int( (spoonacularScore ?? 0) / 20)
    }
    
    var calories: Double {
        nutrition.nutrients.first { $0.name == "Calories" }?.amount ?? 0
    }
    
    var protein: Double {
        nutrition.nutrients.first { $0.name == "Protein" }?.amount ?? 0
    }
    
    var carbs: Double {
        nutrition.nutrients.first { $0.name == "Carbohydrates" }?.amount ?? 0
    }
    
    var fat: Double {
        nutrition.nutrients.first { $0.name == "Fat" }?.amount ?? 0
    }
}

enum CodingKeys: String, CodingKey{
    case id, title, image, imageType, nutrition
    case spoonacularScore = "meta-score"
}

struct RecipeNutrition: Codable {
    let nutrients: [RecipeNutrient]
    let ingredients: [Ingredient]?
}

struct RecipeNutrient: Codable {
    let name: String
    let amount: Double
    let unit: String
} 

struct Ingredient: Codable, Identifiable {
    let id: Int
    let name: String
    let amount: Double
    let image: String?
}


