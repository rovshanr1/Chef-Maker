//
//  AppState.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 16.04.25.
//

import SwiftUI
import FirebaseAuth
import Combine


@MainActor
class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var currentUser: ProfileModel?
    @Published var hasSeenOnboarding: Bool = UserDefaults.standard.bool(forKey: "onboardingShown")
        
    private let auth = Auth.auth()
    private let authService: AuthServiceProtocol
        
    private var cancellables = Set<AnyCancellable>()
    
    init(authService: AuthServiceProtocol = AuthService.shared) {
        self.authService = authService
        checkInitialSession()
       
    }
       
    func checkInitialSession() {
        Task{
            let result = await authService.checkSession()
            isLoggedIn = result
            
            if isLoggedIn{
                loadUserProfile()
            }
        }
    }
    
    func markOnboardingSeen() {
        hasSeenOnboarding = true
        UserDefaults.standard.set(true, forKey: "onboardingShown")
    }
        
    
    func login(){
        isLoggedIn = true
        loadUserProfile()
    }
        
    func logout() async{
        do {
            try await authService.logout()
            isLoggedIn = false
            currentUser = nil
        }catch {
            print("Logout Error: \(error.localizedDescription)")
        }
    }
        
    private func loadUserProfile() {
        guard let currentUser = auth.currentUser else{
            return
        }
            
        Task{
            do{
                if let profile = try await UserService.shared.fetchUserProfile(userId: currentUser.uid){
                    self.currentUser = profile
                }
            } catch {
                print("Load User Error: \(error.localizedDescription)")
            }
        }
        
    }
}

