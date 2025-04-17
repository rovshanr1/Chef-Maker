//
//  FeaturedGridItem.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 16.04.25.
//

import SwiftUI

struct FeaturedCardView: View {
    var recipe: FeaturedModel
    var namespace: Namespace.ID
    @Binding var show: Bool
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(AppColors.adaptiveCardBackground(for: colorScheme))
                .frame(width: 260, height: 300)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)

            VStack(spacing: 12) {
      
                ZStack(alignment: .topTrailing) {
                    AsyncImage(url: URL(string: recipe.image)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .frame(width: 140, height: 140)
                            .offset(y: -80)
                    } placeholder: {
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 140, height: 140)
                            .offset(y: -80)
                    }
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .foregroundColor(.orange)
                        Text("\(recipe.likesCount)")
                            .font(.custom("Poppins-Bold", size: 12))
                            .foregroundColor(.black)
                    }
                    .padding(6)
                    .background(AppColors.cardStarBackground)
                    .cornerRadius(20)
                    .offset(x: 20, y: -40)
                }
                .padding(.top, 16)

             
              
                

                
                VStack {
                    Text(recipe.title)
                        .font(.custom("Poppins-Bold", size: 16))
                        .foregroundColor(.primary)
                        .lineLimit(2)
                        .matchedGeometryEffect(id: "title\(recipe.id)", in: namespace)
                        .frame(height: 40)
                        .offset(y: -60)
                    
                    HStack(spacing: 15) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Time")
                                .font(.custom("Poppins-Regular", size: 18))
                                .foregroundColor(.secondary)
                            Text("\(recipe.cookTime) Mins")
                                .font(.custom("Poppins-Regular", size: 14))
                            
                        }
                        .padding(.bottom)
                        
                        Spacer()
                        
                        Button(action: {
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                            
                        }){
                            Image("Bookmark2")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                        .padding(.bottom, 12)
                        
                    }
                }
                .padding(.bottom)
                
                

            }
            .frame(width: 220, height: 220)
            .padding(.top, 36)
        }
        .frame(width: 260, height: 300)
        .padding(.top, 50)
    }
}

    

//Prewiev
struct FeaturedCardView_Prewiews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        FeaturedCardView(recipe: FeaturedModel(from: Recipe(
            id: 1,
            title: "categorically organized list of foods",
            image: "11",
            imageType: "jpg",
            nutrition: RecipeNutrition(nutrients: [
                RecipeNutrient(name: "Calories", amount: 450, unit: "kcal"),
                RecipeNutrient(name: "Protein", amount: 20, unit: "g"),
                RecipeNutrient(name: "Carbohydrates", amount: 60, unit: "g"),
                RecipeNutrient(name: "Fat", amount: 15, unit: "g")
            ])
        )), namespace: namespace, show: .constant(true))
    }
}


