//
//  AppState.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 16.04.25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

@MainActor
class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var currentProfile: ProfileModel?
    @Published var hasSeenOnboarding: Bool = UserDefaults.standard.bool(forKey: "onboardingShown")
    
    let authService: AuthServiceProtocol
    let profileService = ProfileService()
    let auth = Auth.auth()
    private let db: Firestore
    
    init(authService: AuthServiceProtocol = AuthService(),
        db: Firestore = Firestore.firestore()) {
        self.authService = authService
        self.db = db
        checkInitialSession()
    }
    
    func checkInitialSession() {
        Task {
            let result = await authService.checkSession()
            isLoggedIn = result
            if isLoggedIn {
                await loadUserProfile()
            }
        }
    }
    
    func markOnboardingSeen() {
        hasSeenOnboarding = true
        UserDefaults.standard.set(true, forKey: "onboardingShown")
    }
    
    func login() {
        isLoggedIn = true
        Task {
            await loadUserProfile()
        }
    }
    
    func logout() async throws{
        do {
            try await authService.logout()
            isLoggedIn = false
            currentProfile = nil
        } catch {
            print("Logout Error: \(error.localizedDescription)")
        
        }
    }
    
    func loadUserProfile() async {
        guard let currentUser = authService.currentUser else {
            return
        }
        
        do {
            let doc = try await db.collection("users").document(currentUser.uid).getDocument()
            if let data = doc.data(),
               let profile = ProfileModel.fromFirebase(data) {
                self.currentProfile = profile
            }
        } catch {
            print("Load User Error: \(error.localizedDescription)")
            // TODO: Error handling
        }
    }
    
    func updateUserProfile(fullName: String) async throws {
        guard let user = authService.currentUser else { return }
        try await db.collection("users").document(user.uid).updateData([
            "fullName": fullName,
            "timeStamp": Date().timeIntervalSince1970
        ])
        await loadUserProfile()
    }
}

