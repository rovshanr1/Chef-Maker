//
//  ContentView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 05.04.25.
//

import SwiftUI

struct DiscoveryView: View {
    @StateObject private var viewModel = DiscoveryViewViewModel()
    @State private var scrollOffset: CGFloat = 0
   
    
    private let columns = [
        GridItem(.fixed(150)),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                // Main Content
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        // Spacer for search bar
                        Rectangle()
                            .fill(.clear)
                            .frame(height: 60)
                        
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
                        
                        // Featured Section
                        FeaturedView()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(GeometryReader { geometry in
                        Color.clear.preference(
                            key: ScrollOffsetPreferenceKey.self,
                            value: geometry.frame(in: .named("scroll")).minY
                        )
                    })
                }
                .coordinateSpace(name: "scroll")
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                    scrollOffset = value
                }
                
                // Fixed Search Bar with blur background
                VStack(spacing: 0) {
                    ModernSearchBar(text: $viewModel.searchText)
                        .padding(.horizontal)
                        .background(
                            Rectangle()
                                .fill(.ultraThinMaterial)
                                .edgesIgnoringSafeArea(.top)
                        )
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if scrollOffset < -20 {
                        Text("Discovery")
                            .font(.title2)
                            .fontWeight(.bold)
                            .transition(.move(edge: .top).combined(with: .opacity))
                    }
                }
            }
        }
    }
}

// Preference key for tracking scroll offset
struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    DiscoveryView()
}
