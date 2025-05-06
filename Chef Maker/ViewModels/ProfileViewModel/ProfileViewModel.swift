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
    func updateProfile(profile: ProfileModel) async
    func signOut() async
}

@MainActor
final class ProfileViewModel: BaseViewModel<ProfileModel>, ProfileViewModelProtocol {
    private let appState: AppState
    
    static func preview() -> ProfileViewModel {
        let viewModel = ProfileViewModel(appState: AppState())
        viewModel.data = [MockData.preview]
        return viewModel
    }
    
    var profile: ProfileModel {
        appState.currentProfile ?? ProfileModel(
            id: "",
            fullName: "",
            userName: "",
            photoURL: "",
            email: "",
            bio: "",
            followingCount: 0,
            followersCount: 0,
            postCount: 0,
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
    
 
    
    func updateProfile(profile: ProfileModel) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
        try await appState.profileService.updateProfile(profile)
        appState.currentProfile = profile
        } catch {
            self.error = error as? NetworkError ?? .unknown(error)
        }
    }
    
    
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

