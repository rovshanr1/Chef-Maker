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
    let imageType: String
    let nutrition: RecipeNutrition
    
 
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


struct RecipeNutrition: Codable {
    let nutrients: [RecipeNutrient]
}

struct RecipeNutrient: Codable {
    let name: String
    let amount: Double
    let unit: String
} 
