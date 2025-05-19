//
//  FeaturedGridItem.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 16.04.25.
//

import SwiftUI
import Kingfisher

struct FeaturedCardView: View {
    var recipe: Recipe
    var namespace: Namespace.ID
    @Binding var show: Bool
    @Environment(\.colorScheme) var colorScheme
    
    

    var body: some View {
        VStack {
            Spacer()
         
            VStack {
                Text("\(recipe.shortTitle)".uppercased())
                    .font(.custom("Poppins-Bold", size: 16))
                    .frame(width: 300, alignment: .center)
                
                HStack{
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Time")
                            .font(.custom("Poppins-Regular", size: 16))
                            .foregroundColor(.secondary)
                            
                        
                        Text("\(recipe.cookTime) Mins")
                            .font(.custom("Poppins-Regular", size: 14))
                            
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        
                    }){
                        Image("Bookmark2")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    
                }
                .padding()
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .blur(radius: 20)
                    
            )
        }
        .background(
            KFImage(URL(string: recipe.image))
                .targetCache(CacheManager().imageCache)
                .placeholder{
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .foregroundStyle(AppColors.adaptiveCardBackground(for: colorScheme))
                }
                .fade(duration: 0.5)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        )
        .mask(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
        )
        .frame(height: 300)
        .padding(.horizontal, 20)
        
    }
}

    




