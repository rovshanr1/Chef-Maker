//
//  MainTabVIew.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 01.05.25.
//

import SwiftUI

struct MainTabView: View {
    @State var index: Int = 0
    @State private var showTabBar: Bool = true
    @Environment(\.colorScheme) var colorScheme
   
    var body: some View {
       
            ZStack(alignment: .bottom){
                Group{
                    switch index{
                    case 0:
                        DiscoveryView(showTabbar: self.$showTabBar)
                    case 1:
                        Color.black
                    case 2:
                        Color.blue
                    default:
                        ProfileView(showTabBar: self.$showTabBar)
                    }
                }
               
            }
            .safeAreaInset(edge: .bottom) {
                if showTabBar {
                    TabBarView(index: self.$index)
                }
            }
            .ignoresSafeArea(.keyboard,edges: .bottom)
            .background(AppColors.adaptiveMainTabView(for: colorScheme).ignoresSafeArea())
        }
    }


#Preview {
    MainTabView()
}
