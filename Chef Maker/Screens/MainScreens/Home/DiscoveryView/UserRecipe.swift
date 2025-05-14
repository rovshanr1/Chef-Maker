//
//  UserRecipe.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 14.05.25.
//

import SwiftUI
import Kingfisher

struct UserRecipe: View {
    let userRecipe: PostModel
    let profile: ProfileModel
    
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack {
            KFImage(URL(string: userRecipe.postImage ?? ""))
                .targetCache(CacheManager().imageCache)
                .placeholder{
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .foregroundStyle(AppColors.cardBackground)
                }
                .fade(duration: 0.5)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 370, height: 270)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            
            
            LinearGradient(
                gradient: Gradient(colors: [.black.opacity(0.9), .black.opacity(0.0)]),
                startPoint: .bottom,
                endPoint: .top
            )
            
          
                VStack(alignment: .leading, spacing: 16){
                    Spacer()
                    
                    Text(userRecipe.title)
                        .font(.custom("Poppins-Medium", size: 16))
                        .foregroundStyle(.white)
                    
                    HStack {
                        ProfilePhoto(profile: profile)
                        
                        Text(profile.fullName)
                            .font(.custom("Poppins-Light", size: 14))
                            .foregroundStyle(.white)
                        
                        Spacer()
                        
                        Image("Timer")
                        
                        Text("\(userRecipe.cookingTime)")
                            .font(.custom("Poppins-Regular", size: 14))
                            .foregroundStyle(.white)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
        }
        .frame(width: 370, height: 270)
        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 4)
        .cornerRadius(15)
        
    }
}

#Preview {
    UserRecipe(userRecipe: PostModel.previews, profile: ProfileModel.preview )
}
