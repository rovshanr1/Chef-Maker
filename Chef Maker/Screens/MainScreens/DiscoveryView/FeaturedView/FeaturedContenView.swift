//
//  FeaturedContenView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 16.04.25.
//

import SwiftUI

struct FeaturedContenView: View {
    var recipe: FeaturedModel
    var namepsace: Namespace.ID
    @Binding var show: Bool
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                cover
                    .overlay(alignment: .topTrailing) {
                        closeButton
                    }
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text(recipe.title)
                            .font(.custom("Poppins-Bold", size: 24))
                            .foregroundColor(AppColors.adaptiveText(for: colorScheme))
                            .matchedGeometryEffect(id: "title\(recipe.id)", in: namepsace)
                        
                        HStack(spacing: 20) {
                            HStack(spacing: 4) {
                                Image(systemName: "clock")
                                    .foregroundColor(AppColors.secondaryColor)
                                Text("\(recipe.cookTime) min")
                                    .font(.custom("Poppins-Regular", size: 16))
                                    .foregroundColor(AppColors.adaptiveText(for: colorScheme))
                            }
                            HStack(spacing: 4) {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(AppColors.secondaryColor)
                                Text("\(recipe.likesCount)")
                                    .font(.custom("Poppins-Regular", size: 16))
                                    .foregroundColor(AppColors.adaptiveText(for: colorScheme))
                            }
                        }
                    }
                    
                    if let nutrition = recipe.nutrition {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Nutrition Facts")
                                .font(.custom("Poppins-Bold", size: 20))
                                .foregroundColor(AppColors.adaptiveText(for: colorScheme))
                            
                            ForEach(nutrition.nutrients, id: \.name) { nutrient in
                                HStack {
                                    Text(nutrient.name)
                                        .font(.custom("Poppins-Regular", size: 16))
                                        .foregroundColor(AppColors.adaptiveText(for: colorScheme))
                                    Spacer()
                                    Text("\(Int(nutrient.amount))\(nutrient.unit)")
                                        .font(.custom("Poppins-Medium", size: 16))
                                        .foregroundColor(AppColors.secondaryColor)
                                }
                            }
                        }
                    }
                }
                .padding(24)
            }
        }
        .background(AppColors.adaptiveBackground(for: colorScheme))
    }
    
    var cover: some View {
        AsyncImage(url: URL(string: recipe.image)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 300)
                .matchedGeometryEffect(id: "image\(recipe.id)", in: namepsace)
        } placeholder: {
            Rectangle()
                .fill(AppColors.adaptiveBackground(for: colorScheme))
                .frame(height: 300)
        }
    }
    
    var closeButton: some View {
        Button {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                show.toggle()
            }
        } label: {
            Image(systemName: "xmark")
                .font(.title)
                .foregroundColor(.white)
                .padding(8)
                .background(Color.black.opacity(0.5))
                .clipShape(Circle())
        }
        .padding()
    }
}

//Prewiev
//#Preview{
//    FeaturedView()
//}
