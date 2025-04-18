//
//  MatchView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 18.04.25.
//

import SwiftUI

struct MatchView: View {
    @Namespace var namespace
    @State var show = false
    
    @Environment(\.colorScheme) var colorScheme
    
    var recipe: FeaturedModel
    var body: some View {
        ZStack {
            if !show{
              
            
            } else{
                
            }
        }
       
    }
}

struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        MatchView(recipe: FeaturedModel(from: Recipe(
            id: 1,
            title: "categorically organized list of foods",
            image:"https://spoonacular.com/recipeImages/579247-556x370.jpg",
            imageType: "jpg",
            nutrition: RecipeNutrition(nutrients: [
                RecipeNutrient(name: "Calories", amount: 450, unit: "kcal"),
                RecipeNutrient(name: "Protein", amount: 20, unit: "g"),
                RecipeNutrient(name: "Carbohydrates", amount: 60, unit: "g"),
                RecipeNutrient(name: "Fat", amount: 15, unit: "g")
            ])
        )))
    }
}

