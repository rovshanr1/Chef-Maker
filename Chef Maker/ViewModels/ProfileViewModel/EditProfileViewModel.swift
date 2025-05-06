//
//  EditProfileSection.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 03.05.25.
//

import UIKit

@MainActor
protocol EditProfileViewModelProtocol{
    var email: String { get set }
    var changePassword: String { get set }
    var name: String { get set }
    var userName: String { get set }
    var bio: String { get set }
    
    func uploadProfilePhoto(_ image: UIImage) async throws
    
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
    @Published var photoURL: String = ""
    @Published var isDeletingPhoto = false

    
    private let appState : AppState
    
    init(appState: AppState) {
        self.appState = appState
        super.init()
        loadProfile()
    }
  
    func uploadProfilePhoto(_ image: UIImage) async throws {
        let token = try await appState.getIdToken()
        let result = try await ImageKitService.uploadImageToBackend(image: image, fileName: "profile_\(UUID().uuidString).jpg", token: token)
        self.photoURL = result.url
        guard var profile = appState.currentProfile else { return }
        profile.photoURL = result.url
        profile.fileId = result.fileId 
        try await appState.profileService.updateProfile(profile)
        appState.currentProfile = profile
    }
    
    func deleteProfilePhoto() async {
        guard let fileId = appState.currentProfile?.fileId else { return }
        
        isDeletingPhoto = true
        defer { isDeletingPhoto = false }
        
        do{
            let token = try await appState.getIdToken()
            
            try await ImageKitService.deleteFile(fileId: fileId, token: token)
            
            var profile = appState.currentProfile
            profile?.photoURL = ""
            profile?.fileId = ""
            
            try await appState.profileService.updateProfile(profile!)
            appState.currentProfile = profile
        } catch{
            self.error = error as? NetworkError ?? .unknown(error)
        }
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
        profile.photoURL = self.photoURL
        
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
        self.photoURL = profile?.photoURL ?? ""
    }
    

}



