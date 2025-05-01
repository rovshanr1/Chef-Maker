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
    var body: some View {
        VStack{
            ZStack{
                
                if self.index == 0 {
                     DiscoveryView()
                }else if self.index == 1 {
                    Color.black
                }else if self.index == 2 {
                    Color.blue
                }else{
                    Color.gray
                }
                
            }
            .background(AppColors.adaptiveMainTabView(for: colorScheme).ignoresSafeArea(.all))
            
    
            TabBarView(index: self.$index)
                .ignoresSafeArea(.container, edges: .bottom)
        }
        .background(AppColors.adaptiveMainTabView(for: colorScheme).ignoresSafeArea(.all))
    }
}

#Preview {
    MainTabView()
}
