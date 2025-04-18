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
    
    //Featured Componenet
    @Namespace var namespace
    @StateObject private var featuredViewModel = FeaturedViewModel()
    @State var show = false
    @State var selectedRecipe: FeaturedModel?
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                AppColors.adaptiveMainTabView(for: colorScheme)
                    .ignoresSafeArea()
            
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        // Categories
                        ShowCategoryButton()
                        
                        featuredHeader
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 20) {
                                ForEach(featuredViewModel.data) { recipe in
                                    FeaturedCardView(recipe: recipe, namespace: namespace, show: $show)
                                        .onTapGesture {
                                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                                selectedRecipe = recipe
                                                show.toggle()
                                            }
                                        }
                                }
                            }
                        }
                    
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
                
                if show, let recipe = selectedRecipe {
                    FeaturedContenView(recipe: recipe, namespace: namespace, show: $show)
                        .transition(.asymmetric(
                            insertion: .opacity,
                            removal: .opacity
                        ))
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


//Featured Header
var featuredHeader: some View {
    VStack(alignment: .leading) {
        HStack(){
            Text("Chef's Picks")
                .font(.custom("Poppins-Bold", size: 24))
            
            Spacer()
            
            Button(action: {
                
            }){
                Text("See All")
                    .font(.custom("Poppins-Medium", size: 16))
                    .foregroundStyle(AppColors.secondaryColor)
            }
        }
        .padding(.horizontal)
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
#Preview {
    DiscoveryView()
}
