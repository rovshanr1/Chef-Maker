//
//  MainTabVIew.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 01.05.25.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject private var appState: AppState
    @State var index: Int = 0
    @State private var showTabBar: Bool = true
    @Environment(\.colorScheme) var colorScheme
   
    var body: some View {
       
            ZStack(alignment: .bottom){
                Group{
                    switch index{
                    case 0:
                        if appState.currentProfile != nil {
                            DiscoveryView(appState: appState, showTabbar: self.$showTabBar)
                        } else {
                            ProgressView("Loading profile...")
                        }
                    case 1:
                        SearchView(showTabbar: self.$showTabBar)
                    case 2:
                        NotificationView()
                    default:
                        MyProfileView(appState: appState, showTabBar: self.$showTabBar )
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
        .environmentObject(AppState())
}
