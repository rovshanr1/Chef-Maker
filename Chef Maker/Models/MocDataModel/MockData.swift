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
        imageType: "jpg", aggregateLikes: 12,
        spoonacularScore: 5, nutrition: RecipeNutrition(
            nutrients: [
                RecipeNutrient(name: "Calories", amount: 450, unit: "kcal"),
                RecipeNutrient(name: "Protein", amount: 12, unit: "g"),
                RecipeNutrient(name: "Carbohydrates", amount: 56, unit: "g"),
                RecipeNutrient(name: "Fat", amount: 18, unit: "g")
            ]
        )
    )

    static let sampleIngredient = Ingredient(
        id: 2,
        original: "1 avocado",
        originalName: "avocado",
        name: "Avocado",
        amount: 1,
        unit: "piece",
        unitShort: "pc",
        unitLong: "piece",
        possibleUnits: ["piece", "g"],
        estimatedCost: Cost(value: 1200, unit: "TRY"),
        consistency: "solid",
        shoppingListUnits: ["piece"],
        aisle: "Produce",
        image: "https://spoonacular.com/cdn/ingredients_500x500/avocado.jpg",
        meta: [],
        nutrition: Nutrition(
            nutrients: [
                Nutrient(name: "Calories", amount: 160, unit: "kcal", percentOfDailyNeeds: 8.0),
                Nutrient(name: "Fat", amount: 15, unit: "g", percentOfDailyNeeds: 23.0)
            ],
            properties: [],
            flavonoids: [],
            caloricBreakdown: CaloricBreakdown(percentProtein: 4, percentFat: 77, percentCarbs: 19),
            weightPerServing: WeightPerServing(amount: 100, unit: "g")
        ),
        categoryPath: ["Produce", "Fruits", "Avocados"]
    )
    static let sampleRecipes: [Recipe] = [
        sampleRecipe,
        Recipe(
            id: 1002,
            title: "Avocado Breakfast Toast",
            image: "https://spoonacular.com/recipeImages/637876-556x370.jpg",
            readyInMinutes: 45,
            imageType: "jpg", aggregateLikes: 123,
            spoonacularScore: 4, nutrition: RecipeNutrition(
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
            readyInMinutes: 45,
            imageType: "jpg",
            aggregateLikes: 2342,
            spoonacularScore: 3,
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
            image: "https://spoonacular.com/recipeImages/633547-556x370.jpg", readyInMinutes: 34,
            imageType: "jpg", aggregateLikes: 1212,
            spoonacularScore: 5, nutrition: RecipeNutrition(
                nutrients: [
                    RecipeNutrient(name: "Calories", amount: 490, unit: "kcal"),
                    RecipeNutrient(name: "Protein", amount: 5, unit: "g"),
                    RecipeNutrient(name: "Carbohydrates", amount: 68, unit: "g"),
                    RecipeNutrient(name: "Fat", amount: 24, unit: "g")
                ]
            )
        ),
        Recipe(
            id: 1005,
            title: "Spicy Thai Noodles",
            image: "https://spoonacular.com/recipeImages/715544-556x370.jpg", readyInMinutes: 55,
            imageType: "jpg",
            aggregateLikes: 4123,
            spoonacularScore: 4.5,
            nutrition: RecipeNutrition(
                nutrients: [
                    RecipeNutrient(name: "Calories", amount: 420, unit: "kcal"),
                    RecipeNutrient(name: "Protein", amount: 15, unit: "g"),
                    RecipeNutrient(name: "Carbohydrates", amount: 65, unit: "g"),
                    RecipeNutrient(name: "Fat", amount: 18, unit: "g")
                ]
            )
        ),
        Recipe(
            id: 1006,
            title: "Mediterranean Quinoa Bowl",
            image: "https://spoonacular.com/recipeImages/716429-556x370.jpg", readyInMinutes: 28,
            imageType: "jpg",
            aggregateLikes: 12341243,
            spoonacularScore: 4.8,
            nutrition: RecipeNutrition(
                nutrients: [
                    RecipeNutrient(name: "Calories", amount: 350, unit: "kcal"),
                    RecipeNutrient(name: "Protein", amount: 12, unit: "g"),
                    RecipeNutrient(name: "Carbohydrates", amount: 45, unit: "g"),
                    RecipeNutrient(name: "Fat", amount: 16, unit: "g")
                ]
            )
        ),
        Recipe(
            id: 1007,
            title: "Homemade Pizza Margherita",
            image: "https://spoonacular.com/recipeImages/716381-556x370.jpg", readyInMinutes: 28,
            imageType: "jpg",
            aggregateLikes: 12341,
            spoonacularScore: 4.7,
            nutrition: RecipeNutrition(
                nutrients: [
                    RecipeNutrient(name: "Calories", amount: 280, unit: "kcal"),
                    RecipeNutrient(name: "Protein", amount: 10, unit: "g"),
                    RecipeNutrient(name: "Carbohydrates", amount: 42, unit: "g"),
                    RecipeNutrient(name: "Fat", amount: 8, unit: "g")
                ]
            )
        ),
        Recipe(
            id: 1008,
            title: "Berry Smoothie Bowl",
            image: "https://spoonacular.com/recipeImages/715497-556x370.jpg", readyInMinutes: 20,
            imageType: "jpg",
            aggregateLikes: 41234,
            spoonacularScore: 4.2, nutrition: RecipeNutrition(
                nutrients: [
                    RecipeNutrient(name: "Calories", amount: 240, unit: "kcal"),
                    RecipeNutrient(name: "Protein", amount: 6, unit: "g"),
                    RecipeNutrient(name: "Carbohydrates", amount: 48, unit: "g"),
                    RecipeNutrient(name: "Fat", amount: 4, unit: "g")
                ]
            )
        )
    ]

    static let sampleIngredients: [Ingredient] = [
        sampleIngredient,
        Ingredient(
            id: 1,
            original: "200g mushrooms",
            originalName: "mushrooms",
            name: "Mushrooms",
            amount: 200,
            unit: "g",
            unitShort: "g",
            unitLong: "grams",
            possibleUnits: ["g", "oz"],
            estimatedCost: Cost(value: 800, unit: "TRY"),
            consistency: "solid",
            shoppingListUnits: ["package"],
            aisle: "Produce",
            image: "https://spoonacular.com/cdn/ingredients_500x500/mushrooms.jpg",
            meta: [],
            nutrition: Nutrition(
                nutrients: [
                    Nutrient(name: "Calories", amount: 22, unit: "kcal", percentOfDailyNeeds: 1.0),
                    Nutrient(name: "Protein", amount: 3.1, unit: "g", percentOfDailyNeeds: 6.2)
                ],
                properties: [],
                flavonoids: [],
                caloricBreakdown: CaloricBreakdown(percentProtein: 50, percentFat: 10, percentCarbs: 40),
                weightPerServing: WeightPerServing(amount: 100, unit: "g")
            ),
            categoryPath: ["Produce", "Vegetables", "Mushrooms"]
        ),
        Ingredient(
            id: 2,
            original: "1 avocado",
            originalName: "avocado",
            name: "Avocado",
            amount: 1,
            unit: "piece",
            unitShort: "pc",
            unitLong: "piece",
            possibleUnits: ["piece", "g"],
            estimatedCost: Cost(value: 1200, unit: "TRY"),
            consistency: "solid",
            shoppingListUnits: ["piece"],
            aisle: "Produce",
            image: "https://spoonacular.com/cdn/ingredients_500x500/avocado.jpg",
            meta: [],
            nutrition: Nutrition(
                nutrients: [
                    Nutrient(name: "Calories", amount: 160, unit: "kcal", percentOfDailyNeeds: 8.0),
                    Nutrient(name: "Fat", amount: 15, unit: "g", percentOfDailyNeeds: 23.0)
                ],
                properties: [],
                flavonoids: [],
                caloricBreakdown: CaloricBreakdown(percentProtein: 4, percentFat: 77, percentCarbs: 19),
                weightPerServing: WeightPerServing(amount: 100, unit: "g")
            ),
            categoryPath: ["Produce", "Fruits", "Avocados"]
        ),
        Ingredient(
            id: 3,
            original: "200g chicken breast",
            originalName: "chicken breast",
            name: "Chicken Breast",
            amount: 200,
            unit: "g",
            unitShort: "g",
            unitLong: "grams",
            possibleUnits: ["g", "oz"],
            estimatedCost: Cost(value: 1500, unit: "TRY"),
            consistency: "solid",
            shoppingListUnits: ["package"],
            aisle: "Meat",
            image: "https://spoonacular.com/cdn/ingredients_500x500/chicken-breast.jpg",
            meta: [],
            nutrition: Nutrition(
                nutrients: [
                    Nutrient(name: "Calories", amount: 165, unit: "kcal", percentOfDailyNeeds: 8.0),
                    Nutrient(name: "Protein", amount: 31, unit: "g", percentOfDailyNeeds: 62.0)
                ],
                properties: [],
                flavonoids: [],
                caloricBreakdown: CaloricBreakdown(percentProtein: 80, percentFat: 20, percentCarbs: 0),
                weightPerServing: WeightPerServing(amount: 100, unit: "g")
            ),
            categoryPath: ["Meat", "Poultry"]
        ),
        Ingredient(
            id: 4,
            original: "100g dark chocolate",
            originalName: "dark chocolate",
            name: "Dark Chocolate",
            amount: 100,
            unit: "g",
            unitShort: "g",
            unitLong: "grams",
            possibleUnits: ["g", "oz"],
            estimatedCost: Cost(value: 1000, unit: "TRY"),
            consistency: "solid",
            shoppingListUnits: ["bar"],
            aisle: "Snacks",
            image: "https://spoonacular.com/cdn/ingredients_500x500/dark-chocolate-pieces.jpg",
            meta: [],
            nutrition: Nutrition(
                nutrients: [
                    Nutrient(name: "Calories", amount: 546, unit: "kcal", percentOfDailyNeeds: 27.0),
                    Nutrient(name: "Fat", amount: 31, unit: "g", percentOfDailyNeeds: 48.0)
                ],
                properties: [],
                flavonoids: [],
                caloricBreakdown: CaloricBreakdown(percentProtein: 5, percentFat: 50, percentCarbs: 45),
                weightPerServing: WeightPerServing(amount: 100, unit: "g")
            ),
            categoryPath: ["Snacks", "Chocolate"]
        ),
        Ingredient(
            id: 5,
            original: "200g rice noodles",
            originalName: "rice noodles",
            name: "Rice Noodles",
            amount: 200,
            unit: "g",
            unitShort: "g",
            unitLong: "grams",
            possibleUnits: ["g", "oz"],
            estimatedCost: Cost(value: 700, unit: "TRY"),
            consistency: "solid",
            shoppingListUnits: ["package"],
            aisle: "Pasta and Rice",
            image: "https://spoonacular.com/cdn/ingredients_500x500/rice-noodles.jpg",
            meta: [],
            nutrition: Nutrition(
                nutrients: [
                    Nutrient(name: "Calories", amount: 192, unit: "kcal", percentOfDailyNeeds: 9.5),
                    Nutrient(name: "Carbohydrates", amount: 44, unit: "g", percentOfDailyNeeds: 15.0)
                ],
                properties: [],
                flavonoids: [],
                caloricBreakdown: CaloricBreakdown(percentProtein: 6, percentFat: 1, percentCarbs: 93),
                weightPerServing: WeightPerServing(amount: 100, unit: "g")
            ),
            categoryPath: ["Pasta and Rice", "Noodles"]
        ),
        Ingredient(
            id: 6,
            original: "150g quinoa",
            originalName: "quinoa",
            name: "Quinoa",
            amount: 150,
            unit: "g",
            unitShort: "g",
            unitLong: "grams",
            possibleUnits: ["g", "oz"],
            estimatedCost: Cost(value: 950, unit: "TRY"),
            consistency: "solid",
            shoppingListUnits: ["package"],
            aisle: "Pasta and Rice",
            image: "https://spoonacular.com/cdn/ingredients_500x500/quinoa-cooked.jpg",
            meta: [],
            nutrition: Nutrition(
                nutrients: [
                    Nutrient(name: "Calories", amount: 120, unit: "kcal", percentOfDailyNeeds: 6.0),
                    Nutrient(name: "Protein", amount: 4.1, unit: "g", percentOfDailyNeeds: 8.2)
                ],
                properties: [],
                flavonoids: [],
                caloricBreakdown: CaloricBreakdown(percentProtein: 15, percentFat: 15, percentCarbs: 70),
                weightPerServing: WeightPerServing(amount: 100, unit: "g")
            ),
            categoryPath: ["Pasta and Rice", "Grains"]
        ),
        Ingredient(
            id: 7,
            original: "200g pizza dough",
            originalName: "pizza dough",
            name: "Pizza Dough",
            amount: 200,
            unit: "g",
            unitShort: "g",
            unitLong: "grams",
            possibleUnits: ["g", "oz"],
            estimatedCost: Cost(value: 400, unit: "TRY"),
            consistency: "solid",
            shoppingListUnits: ["package"],
            aisle: "Refrigerated",
            image: "https://spoonacular.com/cdn/ingredients_500x500/pizza-dough.jpg",
            meta: [],
            nutrition: Nutrition(
                nutrients: [
                    Nutrient(name: "Calories", amount: 260, unit: "kcal", percentOfDailyNeeds: 13.0),
                    Nutrient(name: "Carbohydrates", amount: 50, unit: "g", percentOfDailyNeeds: 17.0)
                ],
                properties: [],
                flavonoids: [],
                caloricBreakdown: CaloricBreakdown(percentProtein: 8, percentFat: 10, percentCarbs: 82),
                weightPerServing: WeightPerServing(amount: 100, unit: "g")
            ),
            categoryPath: ["Refrigerated", "Dough"]
        ),
        Ingredient(
            id: 8,
            original: "100g mixed berries",
            originalName: "mixed berries",
            name: "Mixed Berries",
            amount: 100,
            unit: "g",
            unitShort: "g",
            unitLong: "grams",
            possibleUnits: ["g", "cup"],
            estimatedCost: Cost(value: 850, unit: "TRY"),
            consistency: "solid",
            shoppingListUnits: ["package"],
            aisle: "Produce",
            image: "https://spoonacular.com/cdn/ingredients_500x500/mixed-berries.jpg",
            meta: [],
            nutrition: Nutrition(
                nutrients: [
                    Nutrient(name: "Calories", amount: 57, unit: "kcal", percentOfDailyNeeds: 2.8),
                    Nutrient(name: "Carbohydrates", amount: 14, unit: "g", percentOfDailyNeeds: 5.0)
                ],
                properties: [],
                flavonoids: [],
                caloricBreakdown: CaloricBreakdown(percentProtein: 5, percentFat: 5, percentCarbs: 90),
                weightPerServing: WeightPerServing(amount: 100, unit: "g")
            ),
            categoryPath: ["Produce", "Fruits", "Berries"]
        )
    ]


    

    static let sampleResponse = SpoonacularResponse(
        results: sampleRecipes,
        offset: 0,
        number: 4,
        totalResults: 4
    )
}
