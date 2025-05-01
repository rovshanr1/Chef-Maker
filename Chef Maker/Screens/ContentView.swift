//
//  ContentView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 22.04.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var appState = AppState()
    @State private var showMainView: Bool = false
    
    var body: some View {
        Group{
            if showMainView{
                if appState.isLoggedIn{
                    MainTabView()
                }else if !appState.hasSeenOnboarding{
                    OnboardingView()
                }
                else{
                    WelcomeView()
                }
                
            }else{
                AnimatedLogoScreen {
                    withAnimation{
                        showMainView = true
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
