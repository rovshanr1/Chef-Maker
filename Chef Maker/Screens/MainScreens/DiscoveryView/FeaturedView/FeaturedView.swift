//
//  FeaturedView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 16.04.25.
//

import SwiftUI

struct FeaturedView: View {
    @Namespace var namespace
    @StateObject private var viewModel = FeaturedViewModel()
    @State var show = false
    @State var selectedRecipe: FeaturedModel?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 20) {
                ForEach(viewModel.data) { recipe in
                    FeaturedCardView(recipe: recipe, namespace: namespace, show: $show)
                        .onTapGesture {
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                selectedRecipe = recipe
                                show.toggle()
                            }
                        }
                }
            }
            .padding(.horizontal)
        }
        .overlay {
            if show, let recipe = selectedRecipe {
                FeaturedContenView(recipe: recipe, namepsace: namespace, show: $show)
                    .transition(.asymmetric(
                        insertion: .opacity,
                        removal: .opacity
                    ))
            }
        }
        .overlay {
            if viewModel.isLoading {
                ProgressView()
                    .scaleEffect(1.5)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.2))
            }
        }
        .alert("Error", isPresented: .constant(viewModel.error != nil)) {
            Button("OK") {
                viewModel.error = nil
            }
        } message: {
            Text(viewModel.error?.localizedDescription ?? "Unknown error")
        }
    }
}

#Preview {
    FeaturedView()
}
