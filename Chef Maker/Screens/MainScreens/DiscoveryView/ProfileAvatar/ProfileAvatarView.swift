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
                    .font(.custom("Poppins-Bold", size: 16))
                    .foregroundStyle(AppColors.adaptiveText(for: colorScheme))
                
                Text("What are you cooking today?")
                    .font(.custom("Poppins-Regular", size: 12))
                    .foregroundStyle(.secondary)
                    .foregroundStyle(AppColors.adaptiveText(for: colorScheme))
            }
            
            Spacer()
            
            Circle()
                .fill(.gray)
                .frame(width: 60, height: 60)
                .overlay(
                    Text(profile.initials)
                        .font(.custom("Poppins-Bold", size: 16))
                        .foregroundStyle(.white)
                )
               
        }
        .padding(.horizontal)
    }
}


#Preview {
    ProfileAvatarView(profile: .preview)
}
