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
    @Published var hasSeenOnboarding: Bool = false
    @Published var currentProfile: ProfileModel?
    
    private let onboardingStoring: OnboardingStoring
    private let session: SessionManaging
    private let profile: FirestoreRepostory
    
    init(
         onboardingStoring: OnboardingStoring = UserDefaultsOnboardingStoring(),
         session: SessionManaging = SessionManager(authService: AuthService()),
         firebaseRepostory: FirestoreRepostory = FirebaseProfileService(),
    ){
        self.session = session
        self.onboardingStoring = onboardingStoring
        self.profile = firebaseRepostory
        
        self.isLoggedIn = session.isLoggedIn
        self.hasSeenOnboarding = onboardingStoring.hasSeenOnboarding
        
        bootstrap()
    }
   
    private func bootstrap() {
        Task{
            let result = await session.checkSession()
            isLoggedIn = result
            if result{
                await loadUserProfile()
            }
        }
    }
    
    //MARK: - Onboarding
    func markOnboardingSeen() {
        onboardingStoring.markOnboardingSeen()
        hasSeenOnboarding = onboardingStoring.hasSeenOnboarding
    }
    
    //MARK: - Login
    func loginSucceded() {
        Task{
            await session.loginSucceded()
            isLoggedIn = session.isLoggedIn
            if isLoggedIn{
                await loadUserProfile()
            }
        }
    }
    
    func logout() async{
        do{
            try await session.logout()
            isLoggedIn = false
            currentProfile = nil
        }
        catch{
            //TODO: - Crate error handeling
            print("Logout Error: \(error.localizedDescription)")
            isLoggedIn = false
            currentProfile = nil
        }
    }
    
    
    //MARK: - Profile
    func loadUserProfile() async {
        guard let uid = session.currenUser?.uid else {
            return
        }
        do {
            self.currentProfile = try await profile.fetchProfile(for: uid)
        }
        catch{
            print("Load User Profile Error: \(error.localizedDescription)")
            //TODO: - Crate error handeling
        }
    }
    
    
    func upadteUserProfile(fullName: String) async{
        guard let uid = session.currenUser?.uid else {
            return
        }
        
        do{
            try await profile.updateFullName(for: uid, fullName: fullName)
            await loadUserProfile()
        }catch{
            //TODO: - Crate error handeling
            print("Update User Error: \(error.localizedDescription)")
        }
    }
    
//    func login() {
//        isLoggedIn = true
//        Task {
//            await loadUserProfile()
//        }
//    }
//    
//    func logout() async throws{
//        do {
//            try await authService.logout()
//            isLoggedIn = false
//            currentProfile = nil
//        } catch {
//            print("Logout Error: \(error.localizedDescription)")
//            
//        }
//    }
    
//    func loadUserProfile() async {
//        guard let currentUser = authService.currentUser else {
//            return
//        }
//        
//        do {
//            let doc = try await db.collection("users").document(currentUser.uid).getDocument()
//            if let data = doc.data(),
//               let profile = ProfileModel.fromFirebase(data) {
//                self.currentProfile = profile
//            }
//        } catch {
//            print("Load User Error: \(error.localizedDescription)")
//            // TODO: Error handling
//        }
//    }
//    
//    func updateUserProfile(fullName: String) async throws {
//        guard let user = authService.currentUser else { return }
//        try await db.collection("users").document(user.uid).updateData([
//            "fullName": fullName,
//            "timeStamp": Date().timeIntervalSince1970
//        ])
//        await loadUserProfile()
//    }
}

