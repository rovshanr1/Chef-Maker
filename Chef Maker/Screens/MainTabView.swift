//
//  MainTabVIew.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 01.05.25.
//

import SwiftUI

struct MainTabView: View {
    @State var index: Int = 0
    @Environment(\.colorScheme) var colorScheme
   
    @StateObject private var searchViewModel = SearchViewModel()
    

    var body: some View {
       
        GeometryReader { geometry in
            ZStack(alignment: .bottom){
                Group{
                    switch index{
                    case 0:
                        DiscoveryView(searchViewModel: searchViewModel)
                    case 1:
                        Color.black
                    case 2:
                        Color.blue
                    default:
                        ProfileView()
                    }
                }
                
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .safeAreaInset(edge: .bottom) {
                if !searchViewModel.searchActive{
                    TabBarView(index: self.$index)
                        .ignoresSafeArea(.keyboard,edges: .bottom)
                }

            }
            .background(AppColors.adaptiveMainTabView(for: colorScheme).ignoresSafeArea())
        }
    }
}

#Preview {
    MainTabView()
}
