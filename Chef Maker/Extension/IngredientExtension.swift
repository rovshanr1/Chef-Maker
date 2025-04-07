//
//  File.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 07.04.25.
//

import Foundation


extension Ingredient {
    var calories: Double {
        nutrition.getNutrientAmount(for: "Calories")
    }
    
    var protein: Double {
        nutrition.getNutrientAmount(for: "Protein")
    }
    
    var carbs: Double {
        nutrition.getNutrientAmount(for: "Carbohydrates")
    }
    
    var fat: Double {
        nutrition.getNutrientAmount(for: "Fat")
    }
    
    var vitaminC: Double {
        nutrition.getNutrientAmount(for: "Vitamin C")
    }
    
    var nutritionScore: Double {
        nutrition.getPropertyAmount(for: "Nutrition Score")
    }
    
    var formattedCost: String {
        estimatedCost.formattedValue
    }
}
