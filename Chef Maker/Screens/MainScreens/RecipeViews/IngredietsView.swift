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
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                    ForEach(ingredient, id: \.id) { ingredient in
                        ZStack {
                            AppColors.adaptiveCardBackground(for: colorScheme)
                                .ignoresSafeArea()
                            HStack{
                                KFImage(URL(string: ingredient.image ?? ""))
                                    .targetCache(CacheManager.shared.imageCache)
                                    .placeholder {
                                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                                            .foregroundStyle(AppColors.cardBackground)
                                    }
                                    .fade(duration: 0.5)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .cornerRadius(12)
                                    .frame(width: 40, height: 40)
                                    .padding()
                                
                                Text(ingredient.name)
                                    .font(.custom("Poppins-SemiBold", size: 16))
                                    .foregroundStyle(AppColors.adaptiveText(for: colorScheme))
                                
                                Spacer()
                                
                                Text(String(format: "%.0f g", ingredient.amount))
                                    .foregroundStyle(.secondary)

                            }
                            .padding(.horizontal)
                        }
                        .cornerRadius(12)
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.top)
            
            }
        .scrollIndicators(.hidden)
        }
    }

//#Preview {
//    RecipeDetailsView(recipe: MockData.sampleRecipe, profile: ProfileModel.preview, ingredient: MockData.sampleIngredients, nutrition: MockData.sampleRecipe.nutrition.nutrients)
//}
