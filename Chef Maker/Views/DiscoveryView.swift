//
//  ContentView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 05.04.25.
//

import SwiftUI


struct DiscoveryView: View {
    @StateObject private var viewModel = DiscoveryViewViewModel()
    
    // Grid için 2 sütunlu layout
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                // Başlık
                HStack {
                    Text("ChefMaker")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(red: 0.13, green: 0.47, blue: 0.38))
                    Spacer()
                }
                .padding(.horizontal)
                
                // Kategoriler
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
                
                // Yükleniyor veya Hata Durumu
                if viewModel.isLoading {
                    ProgressView()
                } else if let error = viewModel.error {
                    Text(error.localizedDescription)
                        .foregroundColor(.red)
                        .padding()
                }
                
                // Tarifler Grid
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.ingredients.prefix(2)) { ingredient in
                            RecipeCard(recipe: ingredient)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

// Kategori Butonu
struct CategoryButton: View {
    let title: String
    let emoji: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Text(emoji)
                    .font(.title2)
                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(isSelected ? Color(red: 0.13, green: 0.47, blue: 0.38) : Color.gray.opacity(0.1))
            .foregroundColor(isSelected ? .white : .primary)
            .cornerRadius(12)
        }
    }
}

// Tarif Kartı
struct RecipeCard: View {
    let recipe: Ingredient
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Resim
            Group {
                if let imageUrl = recipe.image,
                   let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Color.gray.opacity(0.3)
                    }
                } else {
                    Color.gray.opacity(0.3)
                }
            }
            .frame(height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            // İsim
            Text(recipe.name)
                .font(.headline)
                .lineLimit(2)
            
            // Besin Değerleri
            VStack(alignment: .leading, spacing: 4) {
                Text("\(Int(recipe.calories)) kcal")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                HStack(spacing: 12) {
                    NutrientView(label: "Protein", value: recipe.protein)
                    NutrientView(label: "Karb", value: recipe.carbs)
                    NutrientView(label: "Yağ", value: recipe.fat)
                }
            }
            
            // Miktar
            Text("\(String(format: "%.1f", recipe.amount)) \(recipe.unit)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 4)
    }
}

// Besin değeri gösterimi için yardımcı view
struct NutrientView: View {
    let label: String
    let value: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label)
                .font(.caption2)
                .foregroundColor(.secondary)
            Text(String(format: "%.1fg", value))
                .font(.caption)
                .fontWeight(.medium)
        }
    }
}

#Preview {
    DiscoveryView()
}
