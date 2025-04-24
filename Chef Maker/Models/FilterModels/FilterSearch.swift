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
    case oneStar = 5
    case twoStars = 4
    case threeStars = 3
    case fourStars = 2
    case fiveStars = 1
    
    var id: Int {
        rawValue
    }
    
    var title: String {
        "\(rawValue))"
    }
}
