//
//  SearchGridView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 26.04.25.
//

import SwiftUI

struct RecipeSearchGridView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var viewModel: SearchViewModel
    @State private var selectedRecipe: Recipe?
    
    var namespace: Namespace.ID
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            AppColors.adaptiveMainTabView(for: colorScheme)
                .ignoresSafeArea()
            VStack(spacing: 20){
                HStack{
                    Text("Search \($viewModel.data.count) Result")
                        .font(.custom("Poppins-Medium", size: 18))
                        .padding(.leading)
                }
                
                ScrollView{
                    LazyVGrid(columns: columns, spacing: 16 ){
                        ForEach(viewModel.data){ recipe in
                            NavigationLink(destination: RecipeDetailsView(
                                recipe: recipe, profile: appState.currentProfile!,
                                ingredient: recipe.nutrition.ingredients ?? [],
                                nutrition: recipe.nutrition.nutrients,
                                namespace: namespace, appState: appState,
                                show: .constant(true)
                            )) {
                                RecipeCardView(recipe: recipe)
                            }
                        }
                    }
                }
            }
            .padding(.top)
        }
        
    }
}

#Preview {
    @Previewable @Namespace var namespace
    @Previewable @State var show = true
    
    RecipeSearchView(namespace: namespace, show: $show)
}
