//
//  AppState.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 16.04.25.
//

import SwiftUI
    
    class AppState: ObservableObject {
        @Published var hasSeenOnboarding: Bool
        @Published var isLoggedIn: Bool

        init() {
            self.hasSeenOnboarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
            self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        }

        func setHasSeenOnboarding() {
            hasSeenOnboarding = true
            UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
        }

        func setIsLoggedIn(_ status: Bool) {
            isLoggedIn = status
            UserDefaults.standard.set(status, forKey: "isLoggedIn")
        }
    }


