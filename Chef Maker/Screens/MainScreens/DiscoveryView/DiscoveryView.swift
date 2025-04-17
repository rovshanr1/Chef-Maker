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
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                AppColors.adaptiveMainTabView(for: colorScheme)
                    .ignoresSafeArea()
            
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
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

//Prewiev
struct DiscoveryView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoveryView()
    }
}
