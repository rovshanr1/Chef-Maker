//
//  Ingredient.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 06.04.25.
//

import Foundation

// MARK: - Ingredient Model
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

// MARK: - Cost
struct Cost: Codable {
    let value: Int
    let unit: String
    
    var formattedValue: String {
        let dollars = Double(value) / 100.0
        return String(format: "$%.2f", dollars)
    }
}

// MARK: - Nutrition
struct Nutrition: Codable {
    let nutrients: [Nutrient]
    let properties: [NutritionProperty]
    let flavonoids: [Flavonoid]
    let caloricBreakdown: CaloricBreakdown
    let weightPerServing: WeightPerServing
    
    func getNutrientAmount(for name: String) -> Double {
        nutrients.first { $0.name == name }?.amount ?? 0
    }
    
    func getPropertyAmount(for name: String) -> Double {
        properties.first { $0.name == name }?.amount ?? 0
    }
}

// MARK: - Nutrient Components
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

// MARK: - Ingredient Extensions
