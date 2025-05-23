//
//  MyPostView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 14.05.25.
//

import SwiftUI
import Kingfisher

struct MyPostView: View {
    let userRecipe: PostModel
    
    let columns = [GridItem(.adaptive(minimum: 100), spacing: 4)]
    
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
                .frame(width: 145, height: 100)
            
            
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
                
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(width: 145, height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .padding(.horizontal)
        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 4)
        
    }
}



#Preview {
    ContentView()
        .environmentObject(AppState())
}
