//
//  RecipeExtension.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 07.04.25.
//

import Foundation

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
