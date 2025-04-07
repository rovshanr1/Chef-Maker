//
//  SearchView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 06.04.25.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchObservableObject()
    
    var body: some View {
        NavigationView {
            VStack {
                ModernSearchBar(text: $viewModel.searchText)
                    .padding()
                
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                } else if let error = viewModel.error {
                    SearchErrorView(message: error.localizedDescription)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.data) { recipe in
                                SearchResultCard(recipe: recipe)
                                    .padding(.horizontal)
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
