//
//  RecipeDetailView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 08.04.25.
//

import SwiftUI

struct RecipeDetailView: View {
    @StateObject private var viewModel: RecipeDetailViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(recipe: FeaturedModel) {
        _viewModel = StateObject(wrappedValue: RecipeDetailViewModel(recipe: recipe))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // MARK: - Header Image
                AsyncImage(url: URL(string: viewModel.recipe.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                }
                .frame(height: 250)
                .clipped()
                
                // MARK: - Content
                VStack(alignment: .leading, spacing: 16) {
                    // Title and Stats
                    VStack(alignment: .leading, spacing: 8) {
                        Text(viewModel.recipe.title)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        HStack(spacing: 16) {
                            // Cook Time
                            Label(viewModel.recipe.formattedCookTime, systemImage: "clock")
                            
                            // Likes
                            Label("\(viewModel.recipe.likesCount)", systemImage: "heart.fill")
                                .foregroundColor(.red)
                        }
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    }
                    
                    Divider()
                    
                    // Ingredients Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Ingredients")
                            .font(.headline)
                        
                        // TODO: Add ingredients list when API is ready
                        Text("")
                            .foregroundColor(.secondary)
                    }
                    
                    Divider()
                    
                    // Instructions Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Preparation of the Meal")
                            .font(.headline)
                        
                        // TODO: Add instructions when API is ready
                        Text("")
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 16) {
                    Button(action: {
                        viewModel.toggleFavorite()
                    }) {
                        Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(viewModel.isFavorite ? .red : .primary)
                    }
                    
                    Button(action: {
                        viewModel.shareRecipe()
                    }) {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }
        }
    }
}

//#Preview {
//    NavigationView {
//        RecipeDetailView(recipe: MockData.sampleIngredient)
//    }
//}
