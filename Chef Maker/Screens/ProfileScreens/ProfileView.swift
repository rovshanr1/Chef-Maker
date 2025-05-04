//
//  ProfileView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 02.05.25.
//

import SwiftUI
import Kingfisher


struct ProfileView: View {
    @StateObject var profileViewModel = ProfileViewModel(appState: AppState.shared)
    @Environment(\.colorScheme) var colorScheme
    
    @State private var isExpanded: Bool = false
    @State private var navigationEditScreen: Bool = false
    @State private var navigateBurgerMenu: Bool = false
    @State private var stateTab: ProfileButton = .posts
    
    @Binding var showTabBar: Bool
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0){
                headerView()
                
                ScrollView{
                    
                    profileContent()
                    
                    infoSection()
                    
                    butonSection()
                }
            }
            .padding(.horizontal)
            .background(AppColors.adaptiveMainTabView(for: colorScheme))
            .navigationDestination(isPresented: $navigationEditScreen) {
                EditProfile(profileViewModel: profileViewModel, showTabBar: $showTabBar)
                    .onAppear { showTabBar = false }
                    .onChange(of: navigationEditScreen) { oldValue  ,newValue in
                        if !newValue {
                            showTabBar = true
                        }
                    }
                
            }
            .navigationDestination(isPresented: $navigateBurgerMenu) {
                BurgerMenu()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    
    
    @ViewBuilder
    private func headerView() -> some View{
        VStack(alignment: .center){
            HStack{
                Text("\(profileViewModel.profile.userName)")
                    .font(.custom("Poppins-Bold", size: 22))
                
                Spacer()
                
                Button(action:{
                    navigateBurgerMenu = true
                }){
                    Image(systemName:"line.3.horizontal",)
                        .font(.custom("Poppins-Medium", size: 22))
                        .foregroundStyle(AppColors.adaptiveText(for: colorScheme))
                }
            }
            .padding(.horizontal, 8)
            
        }
    }
    
    @ViewBuilder
    private func profileContent() -> some View{
        HStack{
            ZStack {
                Circle()
                    .fill(.gray)
                    .frame(width: 92, height: 92)
                Group{
                    if let photoURL = profileViewModel.profile.photoURL, let url = URL(string: photoURL) {
                        KFImage(url)
                            .targetCache(CacheManager.shared.imageCache)
                            .fade(duration: 0.5)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                            .frame(width: 92, height: 92)
                        
                    } else {
                        Text(profileViewModel.profile.initials)
                            .font(.custom("Poppins-SemiBold", size: 16))
                            .foregroundColor(.white)
                    }
                }
                
            }
            
            Spacer(minLength: 0)
            
            VStack(alignment: .leading){
                Text("\(profileViewModel.profile.postCount)")
                    .font(.custom("Poppins-SemiBold", size: 16))
                
                Text("recipes")
                    .font(.custom("Poppins-SemiBold", size: 14))
            }
            
            Spacer(minLength: 0)
            
            VStack(alignment: .leading){
                Text("\(profileViewModel.profile.followersCount)")
                    .font(.custom("Poppins-SemiBold", size: 16))
                
                Text("followers")
                    .font(.custom("Poppins-SemiBold", size: 14))
            }
            
            Spacer(minLength: 0)
            
            VStack(alignment: .leading){
                Text("\(profileViewModel.profile.followingCount)")
                    .font(.custom("Poppins-SemiBold", size: 16))
                
                Text("following")
                    .font(.custom("Poppins-SemiBold", size: 14))
                
                
            }
            
        }
        .padding([.top])
    }
    
    @ViewBuilder
    private func infoSection() -> some View {
        
        VStack(alignment: .leading, spacing: 8){
            Text("\(profileViewModel.profile.fullName)")
                .font(.custom("Poppins-Medium", size: 18))
            
            if isExpanded {
                Text(profileViewModel.profile.bio ?? "")
                    .font(.custom("Poppins-Regular", size: 14))
                    .foregroundStyle(.secondary)
            } else {
                Text((profileViewModel.profile.bio ?? "").prefix(100))
                    .font(.custom("Poppins-Regular", size: 14))
                    .foregroundStyle(.secondary)
                
            }
            
            if (profileViewModel.profile.bio ?? "").count > 100 {
                Button(action: {
                    isExpanded.toggle()
                }) {
                    Text(isExpanded ? "less" : "more...")
                        .font(.custom("Poppins-Regular", size: 14))
                        .foregroundColor(Color.secondary)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding([.horizontal, .top], 8)
    }
    
    @ViewBuilder
    private func butonSection() -> some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Button(action: {
                    navigationEditScreen = true
                }){
                    Text("Edit Profile")
                        .font(.custom("Poppins-SemiBold", size: 14))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(12)
                }
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(AppColors.filedFilterButtonColor)
                )
                
            }
            
            VStack {
                HStack{
                    Button(action: {
                        withAnimation{
                            stateTab = .posts
                        }
                    }){
                            VStack {
                                    Image(systemName: stateTab == .posts ? "square.grid.3x3.fill"
                                          : "square.grid.3x3")
                                        .foregroundStyle(AppColors.adaptiveText(for: colorScheme).secondary)
                                        .frame(width: 22, height: 22)
                                    
                                    Rectangle()
                                    .fill(stateTab == .posts ? .gray : .clear)
                                    .frame(height: 2)
                                    .padding(.horizontal)
                                    
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                           
                    }
                    
                    
                    Button(action: {
                        withAnimation{
                            stateTab = .bookmarks
                        }
                    }){
                        VStack {
                            Image(systemName: stateTab == .bookmarks ? "bookmark.fill" : "bookmark")
                                .foregroundStyle(AppColors.adaptiveText(for: colorScheme).secondary)
                                .frame(width: 22, height: 22)
                            
                            Rectangle()
                                .fill(stateTab == .bookmarks ? .gray : .clear)
                                .frame(height: 2)
                                .padding(.horizontal)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        
                    }
                    
                }
                
                if stateTab == .posts {
                    PostView()
                }else if stateTab == .bookmarks {
                    BookmarkView()
                }
            }
        }
        .padding([.top, .horizontal])
        
    }
    
}


#Preview {
    ProfileView(showTabBar: .constant(true))
}
