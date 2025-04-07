//
//  ContentView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 05.04.25.
//

import SwiftUI

struct DiscoveryView: View {
    @StateObject private var viewModel = DiscoveryViewViewModel()
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                // Search bar
                SearchBar(text: $viewModel.searchText)
                    .padding()
                
                // Categories
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(viewModel.filteredCategories, id: \.self) { category in
                            CategoryButton(
                                title: category.rawValue,
                                emoji: category.emoji,
                                isSelected: viewModel.isSelected(category)
                            ) {
                                viewModel.toggleCategory(category)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Loading or Error state
                if viewModel.isLoading {
                    ProgressView()
                } else if let error = viewModel.error {
                    Text(error.localizedDescription)
                        .foregroundColor(.red)
                        .padding()
                }
                
                // Recipe grid
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.data) { recipe in
                            RecipeCard(recipe: recipe)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Discover Recipes")
        }
    }
}

#Preview {
    DiscoveryView()
}
