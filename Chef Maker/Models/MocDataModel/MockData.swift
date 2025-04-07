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
        title: "Kremalı Mantarlı Makarna",
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
            title: "Avokadolu Kahvaltı Tostu",
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
            title: "Izgara Tavuk Salatası",
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
            title: "Çikolatalı Brownie",
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
        original: "2 yemek kaşığı zeytinyağı",
        originalName: "zeytinyağı",
        name: "Zeytinyağı",
        amount: 2.0,
        unit: "yemek kaşığı",
        unitShort: "ykş",
        unitLong: "yemek kaşığı",
        possibleUnits: ["yemek kaşığı", "gram", "ml"],
        estimatedCost: Cost(value: 500, unit: "TL"),
        consistency: "liquid",
        shoppingListUnits: ["şişe", "litre"],
        aisle: "Yağlar",
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
        categoryPath: ["Yağlar", "Bitkisel Yağlar"]
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
