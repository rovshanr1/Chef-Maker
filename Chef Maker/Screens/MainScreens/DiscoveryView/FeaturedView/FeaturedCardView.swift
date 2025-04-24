//
//  FeaturedGridItem.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 16.04.25.
//

import SwiftUI
import Kingfisher

struct FeaturedCardView: View {
    var recipe: FeaturedModel
    var namespace: Namespace.ID
    @Binding var show: Bool
    @Environment(\.colorScheme) var colorScheme
    
    

    var body: some View {
        VStack {
            Spacer()
         
            VStack {
                Text("\(recipe.shortTitle)".uppercased())
                    .font(.custom("Poppins-Bold", size: 16))
                    .matchedGeometryEffect(id: "title\(recipe.id)", in: namespace,  isSource: !show)
                    .frame(width: 300, alignment: .center)
                
                HStack{
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Time")
                            .font(.custom("Poppins-Regular", size: 16))
                            .foregroundColor(.secondary)
                            .matchedGeometryEffect(id: "time\(recipe.id)", in: namespace,  isSource: !show)
                        
                        Text("\(recipe.cookTime) Mins")
                            .font(.custom("Poppins-Regular", size: 14))
                            .matchedGeometryEffect(id: "cookTime\(recipe.id)", in: namespace,  isSource: !show)
                    }
                    
                    
                    Spacer()
                    
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        
                    }){
                        Image("Bookmark2")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    .matchedGeometryEffect(id: "bookmark\(recipe.id)", in: namespace,  isSource: !show)
                }
                .padding()
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .blur(radius: 20)
                    .matchedGeometryEffect(id: "blur\(recipe.id)", in: namespace,  isSource: !show)
            )
        }
        .background(
            KFImage(URL(string: recipe.image))
                .targetCache(CacheManager.shared.imageCache)
                .placeholder{
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .foregroundStyle(AppColors.adaptiveCardBackground(for: colorScheme))
                }
                .fade(duration: 0.5)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .matchedGeometryEffect(id: "image\(recipe.id)", in: namespace, isSource: !show)
        )
        .mask(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .matchedGeometryEffect(id: "mask\(recipe.id)", in: namespace,  isSource: !show)
        )
        .frame(height: 300)
        .padding(20)
        
    }
}

    

//Prewiev
//struct FeaturedCardView_Prewiews: PreviewProvider {
//    @Namespace static var namespace
//    
//    static var previews: some View {
//        FeaturedCardView(recipe: FeaturedModel(from: Recipe(
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
//        )), namespace: namespace, show: .constant(true))
//    }
//}


