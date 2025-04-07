//
//  FeaturedView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 07.04.25.
//

import SwiftUI

struct FeaturedView: View {
    @StateObject private var viewModel = FeaturedViewModel()
    @State private var showingFeaturedList = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // MARK: - Header
            HStack {
                Text("Chef's Picks 🍽️")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.leading)
                
                Spacer()
                
                Button(action: {
                    showingFeaturedList = true
                }) {
                    Text("See All")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(.blue)
                        .padding(.trailing)
                }
            }
            
            if viewModel.isLoading {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                .frame(height: 200)
            } else if let error = viewModel.error {
                HStack {
                    Spacer()
                    VStack(spacing: 8) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.title)
                            .foregroundColor(.orange)
                        Text(error.localizedDescription)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                }
                .frame(height: 200)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(viewModel.data) { recipe in
                            Button(action: {
                                // TODO: Navigate to recipe detail
                            }) {
                                VStack(alignment: .leading, spacing: 8) {
                                    // Image Section
                                    AsyncImage(url: URL(string: recipe.image)) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                    } placeholder: {
                                        Rectangle()
                                            .fill(Color.gray.opacity(0.2))
                                    }
                                    .frame(width: 180, height: 140)
                                    .clipped()
                                    .cornerRadius(12)
                                    
                                    // Info Section
                                    VStack(alignment: .leading, spacing: 6) {
                                        // Title with truncation
                                        Text(recipe.title)
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                            .lineLimit(2)
                                            .multilineTextAlignment(.leading)
                                            .frame(height: 44)
                                        
                                        // Stats Row
                                        HStack(spacing: 12) {
                                            // Cook Time
                                            HStack(spacing: 4) {
                                                Image(systemName: "clock")
                                                    .font(.caption)
                                                Text(recipe.formattedCookTime)
                                                    .font(.caption)
                                            }
                                            .foregroundColor(.secondary)
                                            
                                            Spacer()
                                            
                                            // Likes
                                            HStack(spacing: 4) {
                                                Image(systemName: "heart.fill")
                                                    .font(.caption)
                                                    .foregroundColor(.red)
                                                Text("\(recipe.likesCount)")
                                                    .font(.caption)
                                                    .foregroundColor(.secondary)
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 8)
                                }
                                .frame(width: 180)
                                .background(Color(.systemBackground))
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 8)
        .sheet(isPresented: $showingFeaturedList) {
            FeaturedListView()
        }
    }
}

#Preview {
    FeaturedView()
        .preferredColorScheme(.light)
}
