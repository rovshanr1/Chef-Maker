//
//  SettingManaging.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 01.10.25.
//

import Foundation

protocol OnboardingStoring{
    var hasSeenOnboarding: Bool { get }
    func markOnboardingSeen()
}

final class UserDefaultsOnboardingStoring: OnboardingStoring {
    
    private let key = "onboardingShown"
    
    var hasSeenOnboarding: Bool {
        UserDefaults.standard.bool(forKey: key)
    }
    
    func markOnboardingSeen() {
        UserDefaults.standard.set(true, forKey: key)
    }
}
