//
//  MockData.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 07.04.25.
//

import Foundation

struct MockData {
    static let sampleRecipe = Recipe(
        id: 1001,
        title: "Creamy Mushroom Pasta",
        image: "https://spoonacular.com/recipeImages/579247-556x370.jpg",
        imageType: "jpg",
        nutrition: RecipeNutrition(
            nutrients: [
                RecipeNutrient(name: "Calories", amount: 450, unit: "kcal"),
                RecipeNutrient(name: "Protein", amount: 12, unit: "g"),
                RecipeNutrient(name: "Carbohydrates", amount: 56, unit: "g"),
                RecipeNutrient(name: "Fat", amount: 18, unit: "g")
            ]
        )
    )

    static let sampleRecipes: [Recipe] = [
        sampleRecipe,
        Recipe(
            id: 1002,
            title: "Avocado Breakfast Toast",
            image: "https://spoonacular.com/recipeImages/637876-556x370.jpg",
            imageType: "jpg",
            nutrition: RecipeNutrition(
                nutrients: [
                    RecipeNutrient(name: "Calories", amount: 320, unit: "kcal"),
                    RecipeNutrient(name: "Protein", amount: 8, unit: "g"),
                    RecipeNutrient(name: "Carbohydrates", amount: 30, unit: "g"),
                    RecipeNutrient(name: "Fat", amount: 22, unit: "g")
                ]
            )
        ),
        Recipe(
            id: 1003,
            title: "Grilled Chicken Salad",
            image: "https://spoonacular.com/recipeImages/715523-556x370.jpg",
            imageType: "jpg",
            nutrition: RecipeNutrition(
                nutrients: [
                    RecipeNutrient(name: "Calories", amount: 380, unit: "kcal"),
                    RecipeNutrient(name: "Protein", amount: 32, unit: "g"),
                    RecipeNutrient(name: "Carbohydrates", amount: 15, unit: "g"),
                    RecipeNutrient(name: "Fat", amount: 12, unit: "g")
                ]
            )
        ),
        Recipe(
            id: 1004,
            title: "Chocolate Brownie",
            image: "https://spoonacular.com/recipeImages/633547-556x370.jpg",
            imageType: "jpg",
            nutrition: RecipeNutrition(
                nutrients: [
                    RecipeNutrient(name: "Calories", amount: 490, unit: "kcal"),
                    RecipeNutrient(name: "Protein", amount: 5, unit: "g"),
                    RecipeNutrient(name: "Carbohydrates", amount: 68, unit: "g"),
                    RecipeNutrient(name: "Fat", amount: 24, unit: "g")
                ]
            )
        )
    ]

    static let sampleIngredient = Ingredient(
        id: 2001,
        original: "2 tablespoons olive oil",
        originalName: "olive oil",
        name: "Olive Oil",
        amount: 2.0,
        unit: "tablespoon",
        unitShort: "tbsp",
        unitLong: "tablespoon",
        possibleUnits: ["tablespoon", "gram", "ml"],
        estimatedCost: Cost(value: 500, unit: "TRY"),
        consistency: "liquid",
        shoppingListUnits: ["bottle", "liter"],
        aisle: "Oils",
        image: "olive-oil.jpg",
        meta: [],
        nutrition: Nutrition(
            nutrients: [
                Nutrient(name: "Calories", amount: 120, unit: "kcal", percentOfDailyNeeds: 6.0),
                Nutrient(name: "Fat", amount: 14, unit: "g", percentOfDailyNeeds: 21.5)
            ],
            properties: [NutritionProperty(name: "Glycemic Index", amount: 0, unit: "")],
            flavonoids: [Flavonoid(name: "Anthocyanins", amount: 0, unit: "mg")],
            caloricBreakdown: CaloricBreakdown(percentProtein: 0, percentFat: 100, percentCarbs: 0),
            weightPerServing: WeightPerServing(amount: 27, unit: "g")
        ),
        categoryPath: ["Oils", "Vegetable Oils"]
    )

    static let sampleIngredients: [Ingredient] = [
        sampleIngredient,
    ]

    static let sampleResponse = SpoonacularResponse(
        results: sampleRecipes,
        offset: 0,
        number: 4,
        totalResults: 4
    )
}
