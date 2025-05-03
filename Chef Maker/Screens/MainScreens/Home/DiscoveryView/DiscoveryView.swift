//
//  ContentView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 05.04.25.
//

import SwiftUI

struct DiscoveryView: View {
    //StateObjects
    @StateObject private var featuredViewModel = FeaturedViewModel()
    @StateObject private var profileViewModel = ProfileViewModel(appState: AppState.shared)
    @StateObject private var searchViewModel = SearchViewModel()
    
    //States
    @State private var scrollOffset: CGFloat = 0
    @State var selectedRecipe: Recipe?
    @State var index = 0
    @Binding var showTabbar: Bool
    
    //Animation
    @Namespace var namespace
    @State var show: Bool = false
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            
            VStack{
                ScrollView {
                    
                    RefreshableScrollView(onRefresh: {
                        await featuredViewModel.forceRefresh()
                    }) {
                        VStack(alignment: .leading, spacing: 16) {
                            //Avatar
                            ProfileAvatarView(profile: profileViewModel.profile)
                            
                            //Search
                            ZStack{
                                if searchViewModel.searchActive {
                                    SearchBarView()
                                    
                                }else{
                                    SearchBarView()
                                        .matchedGeometryEffect(id: "Search", in: namespace)
                                }
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.3)){
                                    searchViewModel.searchActive = true
                                }
                            }
                            
                            
                            // Categories
                            ShowCategoryButton()
                            
                            featuredHeader
                            
                            //Featured card
                            featuredRecipes()
                            
                            
                            
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
                
                Spacer()
                
                
                
            }
            .background(AppColors.adaptiveMainTabView(for: colorScheme).ignoresSafeArea())
            .onAppear{
                Task{
                    if featuredViewModel.data.isEmpty{
                        await featuredViewModel.forceRefresh()
                    }
                    print("Data Loaded Successfully: \(featuredViewModel.data.count)")
                    print("Recipe Loaded Successfully:", featuredViewModel.data.map { $0.title})
                }
            }
            .navigationBarBackButtonHidden(true)
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
            .overlay(
                ZStack{
                    if searchViewModel.searchActive{
                        SearchView(namespace: namespace, show: $searchViewModel.searchActive)
                            .onAppear { showTabbar = false }
                            .onDisappear { showTabbar = true }
                        
                    }
                }
            )
            .overlay(
                ZStack{
                    if let selectedRecipe = selectedRecipe, show {
                        RecipeDetailsView(recipe: selectedRecipe,
                                          ingredient: selectedRecipe.nutrition.ingredients ?? [],
                                          nutrition: selectedRecipe.nutrition.nutrients,
                                          namespace: namespace,
                                          show: $show)
                    }
                }
            )
            .onTapGesture{ hideKeyboard() }
        }
    }
    
    
    @ViewBuilder
    func featuredRecipes() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 20) {
                ForEach(featuredViewModel.data) { recipe in
                    FeaturedCardView(recipe: recipe, namespace: namespace, show: $show)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                selectedRecipe = recipe
                                show.toggle()
                            }
                        }
                        .matchedGeometryEffect(id: "\(recipe.id)  image", in: namespace, isSource: !show)
                    
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
                .font(.custom("Poppins-Bold", size: 18))
            
            Spacer()
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


