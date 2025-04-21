//
//  ContentView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 05.04.25.
//

import SwiftUI

struct DiscoveryView: View {
    @StateObject private var viewModel = DiscoveryViewViewModel()
    @StateObject private var featuredViewModel = FeaturedViewModel()
    @State private var scrollOffset: CGFloat = 0
    
    //Featured Componenet
    @Namespace var namespace
   
    @State var show = false
    @State var selectedRecipe: FeaturedModel?
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                AppColors.adaptiveMainTabView(for: colorScheme)
                    .ignoresSafeArea()
            
                ScrollView {
                    RefreshableScrollView(onRefresh: {
                        await featuredViewModel.forceRefresh()
                    }) {
                        VStack(alignment: .leading, spacing: 16) {
                            // Categories
                            ShowCategoryButton()
                            
                            featuredHeader
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) {
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
                        .alert("Error", isPresented: .constant(featuredViewModel.error != nil)) {
                            Button("Ok") {
                                featuredViewModel.error = nil
                            }
                        } message:{
                            Text(featuredViewModel.error?.localizedDescription ?? "Unkonwn Error")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(GeometryReader { geometry in
                            Color.clear.preference(
                                key: ScrollOffsetPreferenceKey.self,
                                value: geometry.frame(in: .named("scroll")).minY
                            )
                        })
                    }
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
            .onAppear{
                Task{
                    await featuredViewModel.forceRefresh()
                    print("DATA: \(featuredViewModel.data.count)")
                    print("🍱 UI verisi:", featuredViewModel.data.map { $0.title })
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
//#Preview {
//    
//}
