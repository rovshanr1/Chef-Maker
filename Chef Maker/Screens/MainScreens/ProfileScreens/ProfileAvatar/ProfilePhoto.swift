//
//  ProfilePhoto.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 28.04.25.
//

import SwiftUI
import Kingfisher

struct ProfilePhoto: View {
    let profile: ProfileModel
    var body: some View {
            ZStack {
                Circle()
                    .fill(.gray)
                Group{
                    if let photoURL = profile.photoURL, let url = URL(string: photoURL) {
                        KFImage(url)
                            .targetCache(CacheManager().imageCache)
                            .fade(duration: 0.5)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                            
                        
                    } else {
                        Text(profile.initials)
                            .font(.custom("Poppins-SemiBold", size: 16))
                            .foregroundColor(.white)
                    }
                }
                    
            }
        }
    
}

//#Preview {
//    ProfilePhoto(profile: .preview)
//}
