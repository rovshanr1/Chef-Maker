//
//  ProfileViewModel.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 23.04.25.
//

import SwiftUI
import FirebaseAuth

@MainActor
protocol ProfileViewModelProtocol: BaseViewModelProtocol {
    func updateProfile(fullName: String) async
//    func uploadProfileImage(_ image: UIImage) async
    func signOut() async
}

@MainActor
final class ProfileViewModel: BaseViewModel<ProfileModel>, ProfileViewModelProtocol {
    private let appState: AppState
    
    var profile: ProfileModel {
        appState.currentProfile ?? ProfileModel(
            id: "",
            fullName: "",
            email: "",
            timeStamp: Date()
        )
    }
    
    var isLoggedIn: Bool {
        appState.isLoggedIn
    }
    
    init(appState: AppState) {
        self.appState = appState
        super.init()
    }
    
    func updateProfile(fullName: String) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await appState.updateUserProfile(fullName: fullName)
        } catch {
            self.error = error as? NetworkError ?? .unknown(error)
        }
    }
    
//    func uploadProfileImage(_ image: UIImage) async {
//        isLoading = true
//        defer { isLoading = false }
//        
//        do {
//            if let user = appState.authService.currentUser {
//                // TODO: try await uploadImageToStorage(image, for: user.uid)
//                print("Profile image upload will be implemented")
//            }
//        } catch {
//            self.error = error as? NetworkError ?? .unknown(error)
//        }
//    }
    
    func signOut() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await appState.logout()
        } catch {
            self.error = error as? NetworkError ?? .unknown(error)
        }
    }
}
