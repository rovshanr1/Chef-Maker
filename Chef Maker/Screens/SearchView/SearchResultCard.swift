//
//  SearchResult.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 07.04.25.
//

import SwiftUI

struct SearchResultCard: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let url = URL(string: recipe.image) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            Text(recipe.title)
                .font(.headline)
                .lineLimit(2)
            
            if let calories = recipe.nutrition.nutrients.first(where: { $0.name == "Calories" }) {
                Text("\(Int(calories.amount)) kcal")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
