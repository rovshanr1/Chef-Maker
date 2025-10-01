//
//  Category.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 06.04.25.
//

import Foundation

enum Category: String, CaseIterable {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case appetizers = "Appetizers"
    case soups = "Soups"
    case salads = "Salads"
    case seafood = "Seafood"
    case meat = "With Meat"
    case chicken = "Chicken"
    case vegan = "Vegans"
    case vegetarian = "Vegetarian"
    case pasta = "Pasta"
    case pizza = "Pizza"
    case fastFood = "Fast Food"
    case desserts = "Desserts"
    case beverages = "Beverages"
    case healthy = "Healthy"
    case glutenFree = "Gluten Free"
    
    var emoji: String {
        switch self {
        case .breakfast: return "🍳"
        case .lunch: return "🥪"
        case .dinner: return "🍽️"
        case .appetizers: return "🥗"
        case .soups: return "🥣"
        case .salads: return "🥬"
        case .seafood: return "🦐"
        case .meat: return "🥩"
        case .chicken: return "🍗"
        case .vegan: return "🥑"
        case .vegetarian: return "🥕"
        case .pasta: return "🍝"
        case .pizza: return "🍕"
        case .fastFood: return "🍔"
        case .desserts: return "🍰"
        case .beverages: return "🥤"
        case .healthy: return "🥗"
        case .glutenFree: return "🌾"
        }
    }
}
