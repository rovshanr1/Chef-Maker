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
        readyInMinutes: 45,
        imageType: "jpg",
        aggregateLikes: 12,
        spoonacularScore: 5.0,
        nutrition: RecipeNutrition(
            nutrients: [
                RecipeNutrient(name: "Calories", amount: 450, unit: "kcal"),
                RecipeNutrient(name: "Protein", amount: 12, unit: "g"),
                RecipeNutrient(name: "Carbohydrates", amount: 56, unit: "g"),
                RecipeNutrient(name: "Fat", amount: 18, unit: "g")
            ],
            ingredients: [
                Ingredient(id: 1, name: "Mushrooms", amount: 200, image: "https://spoonacular.com/cdn/ingredients_500x500/mushrooms.jp"),
                Ingredient(id: 2, name: "Pasta", amount: 250, image: "https://spoonacular.com/cdn/ingredients_500x500/spaghetti.jpg"),
                Ingredient(id: 3, name: "Cream", amount: 100, image: "https://spoonacular.com/cdn/ingredients_500x500/cream.jpg")
            ]
        )
    )

    static let sampleRecipes: [Recipe] = [
        sampleRecipe,
        Recipe(
            id: 1002,
            title: "Avocado Toast",
            image: "https://spoonacular.com/recipeImages/637876-556x370.jpg",
            readyInMinutes: 15,
            imageType: "jpg",
            aggregateLikes: 123,
            spoonacularScore: 4.0,
            nutrition: RecipeNutrition(
                nutrients: [
                    RecipeNutrient(name: "Calories", amount: 320, unit: "kcal"),
                    RecipeNutrient(name: "Protein", amount: 8, unit: "g"),
                    RecipeNutrient(name: "Carbohydrates", amount: 30, unit: "g"),
                    RecipeNutrient(name: "Fat", amount: 22, unit: "g")
                ],
                ingredients: [
                    Ingredient(id: 4, name: "Avocado", amount: 1, image: "https://spoonacular.com/cdn/ingredients_500x500/avocado.jpg"),
                    Ingredient(id: 5, name: "Bread", amount: 2, image: "https://spoonacular.com/cdn/ingredients_500x500/bread.jpg")
                ]
            )
        ),
        Recipe(
            id: 1003,
            title: "Chicken Salad",
            image: "https://spoonacular.com/recipeImages/715523-556x370.jpg",
            readyInMinutes: 30,
            imageType: "jpg",
            aggregateLikes: 2342,
            spoonacularScore: 4.5,
            nutrition: RecipeNutrition(
                nutrients: [
                    RecipeNutrient(name: "Calories", amount: 380, unit: "kcal"),
                    RecipeNutrient(name: "Protein", amount: 32, unit: "g"),
                    RecipeNutrient(name: "Carbohydrates", amount: 15, unit: "g"),
                    RecipeNutrient(name: "Fat", amount: 12, unit: "g")
                ],
                ingredients: [
                    Ingredient(id: 6, name: "Chicken Breast", amount: 200, image: "https://spoonacular.com/cdn/ingredients_500x500/chicken-breast.jpg"),
                    Ingredient(id: 7, name: "Lettuce", amount: 100, image: "https://spoonacular.com/cdn/ingredients_500x500/lettuce.jpg")
                ]
            )
        )
    ]

    static let sampleResponse = SpoonacularResponse(
        results: sampleRecipes,
        offset: 0,
        number: 3,
        totalResults: 3
    )
}
