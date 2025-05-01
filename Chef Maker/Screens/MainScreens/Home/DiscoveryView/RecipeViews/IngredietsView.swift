//
//  IngredietsView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 28.04.25.
//

import SwiftUI
import Kingfisher

struct IngredietsView: View {
    let ingredient: [Ingredient]
    
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                    ForEach(ingredient, id: \.name) { ingredient in
                        ZStack {
                            AppColors.adaptiveCardBackground(for: colorScheme)
                                .ignoresSafeArea()
                            HStack{
//                                KFImage(ingredient.imageUrl)
//                                    .targetCache(CacheManager.shared.imageCache)
//                                    .placeholder {
//                                        RoundedRectangle(cornerRadius: 12, style: .continuous)
//                                            .foregroundStyle(AppColors.cardBackground)
//                                    }
//                                    .fade(duration: 0.5)
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .cornerRadius(12)
//                                    .frame(width: 40, height: 40)
//                                    .padding()
                                
                                Text(ingredient.name)
                                    .font(.custom("Poppins-SemiBold", size: 16))
                                    .foregroundStyle(AppColors.adaptiveText(for: colorScheme))
                                    .padding()
                                
                                Spacer()
                                
                                Text(String(format: "%.2f g", ingredient.amount))
                                    .font(.custom("Poppins-Regular", size: 14))
                                    .foregroundStyle(AppColors.adaptiveText(for: colorScheme).opacity(0.7))

                            }
                            .padding(.horizontal)
                        }
                        .cornerRadius(12)
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.top)
            
        
        }
    }

//#Preview {
//    RecipeDetailsView(recipe: MockData.sampleRecipe, profile: ProfileModel.preview, ingredient: MockData.sampleIngredients, nutrition: MockData.sampleRecipe.nutrition.nutrients)
//}
