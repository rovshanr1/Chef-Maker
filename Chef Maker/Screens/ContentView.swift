//
//  ContentView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 22.04.25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
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
                    WelcomeView(loginViewModel: LoginViewModel(authService: appState.authService, appState: appState))
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
