//
//  MatchView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 18.04.25.
//

import SwiftUI

struct MatchView: View {
    @StateObject var viewModel = FeaturedViewModel()

       var body: some View {
           NavigationView {
               List(viewModel.data, id: \.id) { recipe in
                   VStack(alignment: .leading, spacing: 8) {
                       Text(recipe.title)
                           .font(.headline)
                       
                       Text("Time: \(recipe.cookTime) min")
                           .font(.subheadline)
                       
                       AsyncImage(url: URL(string: recipe.image)) { image in
                           image
                               .resizable()
                               .aspectRatio(contentMode: .fill)
                       } placeholder: {
                           Color.gray.opacity(0.3)
                       }
                       .frame(height: 200)
                       .cornerRadius(12)
                   }
                   .padding(.vertical, 10)
               }
               .navigationTitle("Test Recipes")
           }
           .onAppear {
               Task{
                   await viewModel.loadFeaturedRecipes()
               }
               print("📲 Veriler: \(viewModel.data.count)")
           }
       }
}
