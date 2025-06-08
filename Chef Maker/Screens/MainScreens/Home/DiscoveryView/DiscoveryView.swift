//
//  ContentView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 05.04.25.
//

import SwiftUI

struct DiscoveryView: View {
    @EnvironmentObject var appState: AppState
    
    //StateObjects
    @StateObject private var viewModel = DiscoveryViewViewModel()
    @StateObject private var featuredViewModel = FeaturedViewModel()
    @StateObject var profileViewModel: ProfileViewModel
    @StateObject private var searchViewModel = SearchViewModel()
    
    //States
    @State private var scrollOffset: CGFloat = 0
    @State var index = 0
    @State var selectedRecipe: Recipe?
    @State private var isRefreshing = false
    
    
    //Animation
    @Namespace var namespace
    @State var show: Bool = false
    
    @Environment(\.colorScheme) var colorScheme
    
    
    init(appState: AppState) {
        _profileViewModel = StateObject(wrappedValue: ProfileViewModel(appState: appState, profileUser: appState.currentProfile!))
     }
    
    
    var body: some View {
        NavigationStack {
            
            VStack(alignment: .leading, spacing: 16){
                //Avatar
                ProfileAvatarView(profile: profileViewModel.profile)
                
                    
                    RefreshableScrollView(isRefreshing: $isRefreshing, onRefresh: {
                        await refreshData()
                    }) {
                        VStack(alignment: .leading, spacing: 16) {
                            // Categories
                            ShowCategoryButton()
                            
                            //Featured card
                            hero()
                            
                            //User Recipe
                            userRecipesSection
                        }
                        .background(GeometryReader { geometry in
                            Color.clear.preference(
                                key: ScrollOffsetPreferenceKey.self,
                                value: geometry.frame(in: .named("scroll")).minY
                            )
                        })
                        .alert("Error", isPresented: .constant(featuredViewModel.error != nil)) {
                            Button("Ok") {
                                featuredViewModel.error = nil
                            }
                        } message:{
                            Text(featuredViewModel.error?.localizedDescription ?? "Unkonwn Error")
                        }
                    }
                    .coordinateSpace(name: "scroll")
                    .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                        scrollOffset = value
                    }
            }
            .background(Color.appsBackground.ignoresSafeArea())
            .onAppear{
                Task {
                    if featuredViewModel.data.isEmpty {
                        await featuredViewModel.forceRefresh()
                    }

                    if viewModel.userRecipes.isEmpty {
                        await viewModel.fetchUserRecipes()
                    }
//                    print("Data Loaded Successfully: \(featuredViewModel.data.count)")
//                    print("Recipe Loaded Successfully:", featuredViewModel.data.map { $0.title})
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
                    if let selectedRecipe = selectedRecipe, show {
                        RecipeDetailsView(recipe: selectedRecipe, profile: profileViewModel.profile,
                                          ingredient: selectedRecipe.nutrition.ingredients ?? [],
                                          nutrition: selectedRecipe.nutrition.nutrients,
                                          namespace: namespace, appState: appState,
                                          show: $show)
                    }
                }
            )
            .onTapGesture{ hideKeyboard() }
        }
    }
    
    
    @ViewBuilder
    func hero() -> some View {
        VStack(alignment: .leading, spacing: 16){
            Text("Chef's Picks")
                .font(.custom("Poppins-Bold", size: 18))
                .padding(.leading)
                
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(featuredViewModel.data) { recipe in
                        FeaturedCardView(recipe: recipe, namespace: namespace, show: $show)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    if selectedRecipe?.id == recipe.id {
                                        show.toggle()
                                    }else{
                                        selectedRecipe = recipe
                                        show = true
                                    }
                                }
                            }
                            .matchedGeometryEffect(id: "\(recipe.id)  image", in: namespace, isSource: !show)
                    }
                }
            }
        }
        .padding([.top])
    }
    

    private var userRecipesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("New Recipes")
                .font(.custom("Poppins-Bold", size: 18))
                .padding(.leading)
            
            ForEach(viewModel.userRecipes) { post in
                UserRecipe(
                    userRecipe: post,
                    profile: viewModel.getProfile(for: post.authorId)
                )
                .onAppear {
                    if post.id == viewModel.userRecipes.last?.id {
                        Task {
                            await viewModel.loadMorePosts()
                        }
                    }
                }
            }
            
            if viewModel.isLoadingMore {
                ProgressView()
                    .padding()
            }
        }
    }
    
    func refreshData() async {
        await viewModel.fetchUserRecipes()
    }

}







// Preference key for tracking scroll offset
struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview{
  ContentView()
        .environmentObject(AppState())
}


