//
//  TabViewModel.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 01.05.25.
//

import Foundation


enum AppTab: CaseIterable{
    case discovery, savedRecipes, notification, profile
    
    var iconName: String {
        switch self {
        case .discovery:
            return "home-2"
        case .savedRecipes:
            return "Inactive"
        case .notification:
            return "notification-bing"
        case .profile:
            return "profile"
        }
    }
    
    var activeIconName: String {
        switch self {
        case .discovery:
            return "active-home-2"
        case .savedRecipes:
            return "Active"
        case .notification:
            return "active-notification-bing"
        case .profile:
            return "active-profile"
        }
    }
    
}
