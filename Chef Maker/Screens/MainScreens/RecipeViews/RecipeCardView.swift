//
//  RecipeCardView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 27.04.25.
//

import SwiftUI
import Kingfisher

struct RecipeCardView: View {
    let recipe: Recipe
    
    var body: some View {
            ZStack {
                KFImage(URL(string: recipe.image))
                    .targetCache(CacheManager.shared.imageCache)
                    .placeholder{
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .foregroundStyle(AppColors.cardBackground)
                    }
                    .fade(duration: 0.5)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 170, height: 170)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                
                
                LinearGradient(
                    gradient: Gradient(colors: [.black.opacity(0.9), .black.opacity(0.0)]),
                    startPoint: .bottom,
                    endPoint: .top
                )
                
                
                
                VStack(alignment: .trailing) {
                    HStack{
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundStyle(AppColors.secondaryColor)
                        
                        
                        Text("\(recipe.starRating)")
                            .font(.system(size: 12))
                            .foregroundStyle(.white)
                        
                    }
                    .padding(8)
                    .background(.gray.opacity(0.6))
                    .cornerRadius(12)
                   
                    
                    Spacer()
                }
                .frame(width: 170, alignment: .trailing)
                .padding([.top, .trailing], 8)
                
                
                VStack(alignment: .leading, spacing: 4){
                    Spacer()
                    
                    Text(recipe.title)
                        .font(.custom("Poppins-Medium", size: 16))
                        .foregroundStyle(.white)
                    //TODO: - by author
                    
                }
                .padding()
                
            }
            .frame(width: 170, height: 170)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 4)
            .cornerRadius(15)
    
    }
        
}

//#Preview {
//    
//    SearchGridView(viewModel: SearchViewModel.preview())
//}
