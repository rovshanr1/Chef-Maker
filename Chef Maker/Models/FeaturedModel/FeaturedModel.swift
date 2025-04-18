//
//  FeaturedModel.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 07.04.25.
//

import Foundation

// MARK: - API Response
struct SpoonacularFeaturedResponse: Codable {
    let results: [FeaturedModel]
}

struct FeaturedModel: Identifiable, Codable {
    let id: Int
    let title: String
    let image: String
    let readyInMinutes: Int
    let aggregateLikes: Int
    let nutrition: RecipeNutrition?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case image
        case readyInMinutes
        case aggregateLikes
        case nutrition
    }
    
    init(from recipe: Recipe) {
        self.id = recipe.id
        self.title = recipe.title
        self.image = recipe.image
        self.readyInMinutes = 30
        self.aggregateLikes = Int.random(in: 100...1000) 
        self.nutrition = recipe.nutrition
    }
    
    var cookTime: Int {
        readyInMinutes
    }
    
    var likesCount: Int {
        aggregateLikes
    }
    
    var formattedCookTime: String {
        "\(readyInMinutes) min"
    }
}




