//
//  NutritionsView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 28.04.25.
//

import SwiftUI

struct NutritionsView: View {
    let nutrients: [RecipeNutrient]
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(nutrients, id: \.name) { nutrient in
                    ZStack {
                        AppColors.adaptiveCardBackground(for: colorScheme)
                         
                        HStack {
                                Text(nutrient.name)
                                    .font(.custom("Poppins-SemiBold", size: 16))
                                    .foregroundStyle(AppColors.adaptiveText(for: colorScheme))
                                    .padding()
                            
                            Spacer()
                            
                                Text("\(nutrient.amount, specifier: "%.1f") \(nutrient.unit)")
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
        .scrollIndicators(.hidden)
    }
}

//#Preview {
//    NutritionsView(nutrients: MockData.sampleRecipe.nutrition.nutrients)
//}
