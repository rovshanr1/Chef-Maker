//
//  FilterSearch.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 24.04.25.
//

import Foundation

// Time
enum TimeFilter: String, CaseIterable, Identifiable {
    case all = "All"
    case newest = "Newest"
    case popularity = "Popularity"
    case oldest = "Oldest"
    case stars = "Stars"
    
    var id: String {
        rawValue
    }
}

// Rate
enum RateFilter: Int, CaseIterable, Identifiable {
    case oneStar = 1
    case twoStars = 2
    case threeStars = 3
    case fourStars = 4
    case fiveStars = 5
    
    var id: Int {
        rawValue
    }
    
    var title: String {
        "\(rawValue)"
    }
}

enum CategoryFilter: String, CaseIterable, Identifiable {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case soups = "Soups"
    case salads = "Salads"
    case seafood = "Seafood"
    case chicken = "Chicken"
    case vegan = "Vegans"
    case pasta = "Pasta"
    case pizza = "Pizza"
    case desserts = "Desserts"
    case healthy = "Healthy"
    
    var id: String {
        rawValue
    }
    
}
