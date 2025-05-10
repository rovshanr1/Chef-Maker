//
//  ProfileViewModel.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 23.04.25.
//

import SwiftUI
import Combine


@MainActor
protocol ProfileViewModelProtocol: BaseViewModelProtocol {
    func updateProfile(profile: ProfileModel) async
    func checkFollowingStatus(targetUserID: String) async
    func signOut() async
}

@MainActor
final class ProfileViewModel: BaseViewModel<ProfileModel>, ProfileViewModelProtocol {
    
    private let appState: AppState
    private let profileUser: ProfileModel
    
    @Published var isFollowingUser: Bool = false
    @State private var isCurrentUserProfile: Bool = true 
    
    static func preview() -> ProfileViewModel {
        let viewModel = ProfileViewModel(appState: AppState(), profileUser: ProfileModel.preview)
        viewModel.data = [MockData.preview]
        return viewModel
    }
    
    var profile: ProfileModel {
     profileUser
    }
    
    var isCurrentUser: Bool {
        profileUser.id == appState.currentProfile?.id
    }
    
    var isLoggedIn: Bool {
        appState.isLoggedIn
    }
    
    init(appState: AppState, profileUser: ProfileModel) {
        self.appState = appState
        self.profileUser = profileUser
        super.init()
        self.data = [profileUser]
    }
    
 
   

    func checkFollowingStatus(targetUserID: String) async {
        guard let currentUserID = appState.currentProfile?.id else { return }

        do {
            let result = try await appState.profileService.isFollowing(
                currentUserID: currentUserID,
                targetUserID: targetUserID
            )
            isFollowingUser = result
        } catch {
            print("Error checking follow status: \(error)")
        }
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

