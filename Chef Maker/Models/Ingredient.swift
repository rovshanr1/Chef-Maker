//
//  Ingredient.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 06.04.25.
//

import Foundation

struct Ingredient: Codable, Identifiable {
    let id: Int
    let original: String
    let originalName: String
    let name: String
    let amount: Double
    let unit: String
    let unitShort: String
    let unitLong: String
    let possibleUnits: [String]
    let estimatedCost: Cost
    let consistency: String
    let shoppingListUnits: [String]
    let aisle: String
    let image: String?
    let meta: [String]
    let nutrition: Nutrition
    let categoryPath: [String]
}

struct Cost: Codable {
    let value: Int
    let unit: String
}

struct Nutrition: Codable {
    let nutrients: [Nutrient]
    let properties: [NutritionProperty]
    let flavonoids: [Flavonoid]
    let caloricBreakdown: CaloricBreakdown
    let weightPerServing: WeightPerServing
}

struct Nutrient: Codable {
    let name: String
    let amount: Double
    let unit: String
    let percentOfDailyNeeds: Double
}

struct NutritionProperty: Codable {
    let name: String
    let amount: Double
    let unit: String
}

struct Flavonoid: Codable {
    let name: String
    let amount: Double
    let unit: String
}

struct CaloricBreakdown: Codable {
    let percentProtein: Double
    let percentFat: Double
    let percentCarbs: Double
}

struct WeightPerServing: Codable {
    let amount: Int
    let unit: String
}


extension Ingredient {
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
    

    var vitaminC: Double {
        nutrition.nutrients.first { $0.name == "Vitamin C" }?.amount ?? 0
    }
    
    
    var nutritionScore: Double {
        nutrition.properties.first { $0.name == "Nutrition Score" }?.amount ?? 0
    }
    
  
    var formattedCost: String {
        let dollars = Double(estimatedCost.value) / 100.0
        return String(format: "$%.2f", dollars)
    }
}

// API Response model
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
}

struct RecipeNutrition: Codable {
    let nutrients: [RecipeNutrient]
}

struct RecipeNutrient: Codable {
    let name: String
    let amount: Double
    let unit: String
}


extension Recipe {
    func toIngredient() -> Ingredient {
        return Ingredient(
            id: id,
            original: title,
            originalName: title,
            name: title,
            amount: 1.0,
            unit: "serving",
            unitShort: "serving",
            unitLong: "serving",
            possibleUnits: ["serving"],
            estimatedCost: Cost(value: 0, unit: "US Cents"),
            consistency: "solid",
            shoppingListUnits: ["serving"],
            aisle: "",
            image: image,
            meta: [],
            nutrition: Nutrition(
                nutrients: nutrition.nutrients.map { nutrient in
                    Nutrient(
                        name: nutrient.name,
                        amount: nutrient.amount,
                        unit: nutrient.unit,
                        percentOfDailyNeeds: 0
                    )
                },
                properties: [],
                flavonoids: [],
                caloricBreakdown: CaloricBreakdown(
                    percentProtein: 0,
                    percentFat: 0,
                    percentCarbs: 0
                ),
                weightPerServing: WeightPerServing(amount: 0, unit: "g")
            ),
            categoryPath: []
        )
    }
}
