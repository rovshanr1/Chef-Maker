//
//  FeaturedGreedItem.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 07.04.25.
//

import SwiftUI

struct FeaturedGridItem: View {
    let recipe: FeaturedModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            // Image
            AsyncImage(url: URL(string: recipe.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
            }
            .frame(height: 100)
            .clipped()
            .cornerRadius(10)
            
            // Title
            Text(recipe.title)
                .font(.caption)
                .fontWeight(.medium)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .frame(height: 32)
            
            // Stats
            HStack(spacing: 8) {
                // Cook Time
                HStack(spacing: 2) {
                    Image(systemName: "clock")
                        .font(.caption2)
                    Text(recipe.formattedCookTime)
                        .font(.caption2)
                }
                .foregroundColor(.secondary)
                
                Spacer()
                
                // Likes
                HStack(spacing: 2) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                        .font(.caption2)
                    Text("\(recipe.likesCount)")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(8)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 1)
    }
}


