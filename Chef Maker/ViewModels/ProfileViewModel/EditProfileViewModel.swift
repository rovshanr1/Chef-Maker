//
//  EditProfileSection.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 03.05.25.
//

import Foundation

@MainActor
protocol EditProfileViewModelProtocol{
    var email: String { get set }
    var changePassword: String { get set }
    var name: String { get set }
    var userName: String { get set }
    var bio: String { get set }
    
    func updateProfile() async
    func loadProfile()
}

@MainActor
class EditProfileViewModel:BaseViewModel<ProfileModel>, EditProfileViewModelProtocol  {
    @Published var email: String = ""
    @Published var changePassword: String = ""
    @Published var name: String = ""
    @Published var userName: String = ""
    @Published var bio: String = ""
    
    private let appState : AppState
    
    init(appState: AppState) {
        self.appState = appState
        super.init()
        loadProfile()
    }
    
    func updateProfile() async {
        guard !name.isEmpty else { self.profileError = .emptyName; return }
        guard !userName.isEmpty else { self.profileError = .emptyUserName; return }
        guard email.contains("@") else { self.profileError = .invalidEmail; return }
        
        guard var profile = appState.currentProfile else {
            return
        }
        
        profile.fullName = name
        profile.userName = userName
        profile.email = email
        profile.bio = bio
        
        isLoading = true
        defer { isLoading = false }
        
        do{
            try await appState.profileService.updateProfile(profile)
            appState.currentProfile = profile
        }catch{
            self.error = error as? NetworkError ?? .unknown(error)
        }
        
    }
    
    func loadProfile() {
        let profile = appState.currentProfile
        
        self.name = profile?.fullName ?? ""
        self.userName = profile?.userName ?? ""
        self.email = profile?.email ?? ""
        self.bio = profile?.bio ?? ""
    }
}
