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
        ),
        // Yüksek puanlı tarifler
        Recipe(
            id: 1004,
            title: "Gourmet Pasta Carbonara",
            image: "https://spoonacular.com/recipeImages/716429-556x370.jpg",
            readyInMinutes: 25,
            imageType: "jpg",
            aggregateLikes: 5000,
            spoonacularScore: 5.0,
            nutrition: RecipeNutrition(
                nutrients: [
                    RecipeNutrient(name: "Calories", amount: 520, unit: "kcal"),
                    RecipeNutrient(name: "Protein", amount: 25, unit: "g"),
                    RecipeNutrient(name: "Carbohydrates", amount: 45, unit: "g"),
                    RecipeNutrient(name: "Fat", amount: 28, unit: "g")
                ],
                ingredients: [
                    Ingredient(id: 8, name: "Pasta", amount: 300, image: "https://spoonacular.com/cdn/ingredients_500x500/spaghetti.jpg"),
                    Ingredient(id: 9, name: "Eggs", amount: 3, image: "https://spoonacular.com/cdn/ingredients_500x500/eggs.jpg"),
                    Ingredient(id: 10, name: "Pancetta", amount: 150, image: "https://spoonacular.com/cdn/ingredients_500x500/pancetta.jpg")
                ]
            )
        ),
        // Sağlıklı tarifler
        Recipe(
            id: 1005,
            title: "Quinoa Salad Bowl",
            image: "https://spoonacular.com/recipeImages/716430-556x370.jpg",
            readyInMinutes: 20,
            imageType: "jpg",
            aggregateLikes: 1500,
            spoonacularScore: 4.8,
            nutrition: RecipeNutrition(
                nutrients: [
                    RecipeNutrient(name: "Calories", amount: 280, unit: "kcal"),
                    RecipeNutrient(name: "Protein", amount: 15, unit: "g"),
                    RecipeNutrient(name: "Carbohydrates", amount: 35, unit: "g"),
                    RecipeNutrient(name: "Fat", amount: 8, unit: "g")
                ],
                ingredients: [
                    Ingredient(id: 11, name: "Quinoa", amount: 200, image: "https://spoonacular.com/cdn/ingredients_500x500/quinoa.jpg"),
                    Ingredient(id: 12, name: "Mixed Vegetables", amount: 150, image: "https://spoonacular.com/cdn/ingredients_500x500/vegetables.jpg")
                ]
            )
        ),
        // Kahvaltı tarifleri
        Recipe(
            id: 1006,
            title: "Healthy Breakfast Bowl",
            image: "https://spoonacular.com/recipeImages/716431-556x370.jpg",
            readyInMinutes: 15,
            imageType: "jpg",
            aggregateLikes: 2000,
            spoonacularScore: 4.7,
            nutrition: RecipeNutrition(
                nutrients: [
                    RecipeNutrient(name: "Calories", amount: 350, unit: "kcal"),
                    RecipeNutrient(name: "Protein", amount: 18, unit: "g"),
                    RecipeNutrient(name: "Carbohydrates", amount: 40, unit: "g"),
                    RecipeNutrient(name: "Fat", amount: 12, unit: "g")
                ],
                ingredients: [
                    Ingredient(id: 13, name: "Oats", amount: 100, image: "https://spoonacular.com/cdn/ingredients_500x500/oats.jpg"),
                    Ingredient(id: 14, name: "Berries", amount: 100, image: "https://spoonacular.com/cdn/ingredients_500x500/berries.jpg")
                ]
            )
        )
    ]

    static let sampleResponse = SpoonacularResponse(
        results: sampleRecipes,
        offset: 0,
        number: 6,
        totalResults: 6
    )
    
    static let preview = ProfileModel(
        id: "user123",
        fullName: "Ayşe Demir",
        userName: "ayse.02",
        photoURL: "https://picsum.photos/200",
        email: "ayse.demir@example.com",
        bio: "hi i am a student",
        followingCount: 3,
        followersCount: 2,
        postCount: 4,
        timeStamp: Date()
    )
    
}
