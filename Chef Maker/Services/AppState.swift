//
//  AppState.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 16.04.25.
//

import SwiftUI
import FirebaseAuth
    @MainActor
    class AppState: ObservableObject {
        @Published var isLoggedIn: Bool = false
        @Published var currentUser: ProfileModel?

        let auth = Auth.auth()
        
        private let authService: AuthServiceProtocol
        
        init(authService: AuthServiceProtocol = AuthService.shared) {
            self.authService = authService
            checkInitialSession()
        }
        
        func checkInitialSession() {
            Task{
                isLoggedIn = await authService.checkSession()
                if isLoggedIn{
                    loadUserProfile()
                }
            }
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
                print("\(error.localizedDescription)")
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
                    print("\(error.localizedDescription)")
                }
            }
            
        }
      
    }


