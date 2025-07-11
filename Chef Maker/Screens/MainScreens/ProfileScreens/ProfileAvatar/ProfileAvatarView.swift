//
//  ProfileAvatarView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 23.04.25.
//

import SwiftUI


struct ProfileAvatarView: View {
    let profile: ProfileModel
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        HStack{
            
            VStack(alignment: .leading, spacing: 8) {
                Text(profile.fullName)
                    .font(.custom("Poppins-SemiBold", size: 20))
                    .foregroundStyle(AppColors.adaptiveText(for: colorScheme))
                
                Text("What are you cooking today?")
                    .font(.custom("Poppins-Regular", size: 12))
                    .foregroundStyle(.secondary)
                    .foregroundStyle(AppColors.adaptiveText(for: colorScheme))
            }
            .padding(.leading, 2)
            
            Spacer()
            
            //Profile Photo
            ProfilePhoto(profile: profile)
                .frame(width: 52, height: 52)
        }
        .padding(.horizontal)
    }
}





//#Preview {
//    ProfileAvatarView(profile: .preview)
//}
