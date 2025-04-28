//
//  FeaturedContenView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 16.04.25.
//

import SwiftUI
import Kingfisher

struct FeaturedContenView: View {
    var recipe: Recipe
    var namespace: Namespace.ID
    @Binding var show: Bool
    @Environment(\.colorScheme) var colorScheme
    
    
    
    
    var body: some View {
        ZStack {
            ScrollView {
                cover
            }
            .ignoresSafeArea()
            
            Button(action: {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)){
                    show.toggle()
                }
            }){
                Image(systemName: "xmark")
                    .font(.body.weight(.bold))
                    .foregroundStyle(AppColors.adaptiveText(for: colorScheme).secondary)
                    .padding(8)
                    .background(.ultraThinMaterial, in: Circle())
                    .frame(width: 44, height: 44)
                    .padding(20)
                    .contentShape(Rectangle())
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(20)
            .ignoresSafeArea()
            .zIndex(1)

        }
    }
    
    var cover: some View {
        VStack {
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 500)
        .background(
            KFImage(URL(string: recipe.image))
                .targetCache(CacheManager.shared.imageCache)
                .placeholder {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                .foregroundStyle(AppColors.adaptiveBackground(for: colorScheme).secondary)
            }
            .fade(duration: 0.5)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 500)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .matchedGeometryEffect(id: "image\(recipe.id)", in: namespace, isSource: show)
        )
        .mask(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .matchedGeometryEffect(id: "mask\(recipe.id)", in: namespace, isSource: show)
        )
        .overlay(
            VStack(alignment: .leading, spacing: 12){
                Text("\(recipe.shortTitle)".uppercased())
                    .font(.custom("Poppins-Bold", size: 16))
                    .matchedGeometryEffect(id: "title\(recipe.id)", in: namespace, isSource: show)
                    .lineLimit(2)
                    .frame(width: 300)
                
                HStack(spacing: 15){
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Time")
                            .font(.custom("Poppins-Regular", size: 16))
                            .foregroundColor(.secondary)
                            .matchedGeometryEffect(id: "time\(recipe.id)", in: namespace, isSource: show)
                        
                        Text("\(recipe.cookTime) Mins")
                            .font(.custom("Poppins-Regular", size: 14))
                            .matchedGeometryEffect(id: "cookTime\(recipe.id)", in: namespace, isSource: show)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        
                    }){
                        Image("Bookmark2")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    .matchedGeometryEffect(id: "bookmark\(recipe.id)", in: namespace, isSource: show)
                    
                }
//                Divider()
//                VStack(alignment: .leading, spacing: 8){
//                    Text("Nutritional Information")
//                        .font(.custom("Poppins-Bold", size: 12))
//                        .foregroundStyle(AppColors.adaptiveText(for: colorScheme).secondary)
                    
                    
                        
                    
//                }
            }
                .padding(20)
                .background(
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .matchedGeometryEffect(id: "blur\(recipe.id)", in: namespace, isSource: show)
                )
                .offset(y: 250)
                .padding(20)
            
        )
    }
}


//
//struct FeaturedContenView_Preview: PreviewProvider {
//    @Namespace static var namespace
//    static var previews: some View {
//        FeaturedContenView(recipe: FeaturedModel(from: Recipe(
//            id: 1,
//            title: "categorically organized list of foods",
//            image: "https://spoonacular.com/recipeImages/579247-556x370.jpg",
//            imageType: "jpg",
//            nutrition: RecipeNutrition(nutrients: [
//                RecipeNutrient(name: "Calories", amount: 450, unit: "kcal"),
//                RecipeNutrient(name: "Protein", amount: 20, unit: "g"),
//                RecipeNutrient(name: "Carbohydrates", amount: 60, unit: "g"),
//                RecipeNutrient(name: "Fat", amount: 15, unit: "g")
//            ])
//        )),
//                           namespace: namespace,
//                           show: .constant(true))
//    }
//}
