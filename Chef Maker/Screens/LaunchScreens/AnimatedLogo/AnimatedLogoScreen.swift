//
//  LaunchScreen.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 08.04.25.
//

import SwiftUI

struct AnimatedLogoScreen: View {
    @State private var isLogoVisible = false
    @State private var scale = 0.3
    @State private var opacity = 0.0
    @State private var rotation = 0.0
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @State private var isAnimationComplete = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.lightBackground
                    .ignoresSafeArea()
                
                VStack {
                    Image("ChefMaker") 
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .scaleEffect(scale)
                        .opacity(opacity)
                        .rotationEffect(.degrees(rotation))
                }
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 0.7)) {
                    scale = 1.0
                    opacity = 1.0
                    rotation = 360
                }
                
              
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    isAnimationComplete = true
                }
            }
            .navigationDestination(isPresented: $isAnimationComplete) {
                if hasSeenOnboarding {
                    WelcomeView()
                } else {
                    OnboardingView()
                }
            }
        }
    }
}

#Preview {
    AnimatedLogoScreen()
}
