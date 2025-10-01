//
//  Items.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 28.04.25.
//

import Foundation

//MARK: - Recipe Detail Tab
enum DetailTab{
    case ingredients
    case nutrition
}

//MARK: - Bookmark Status
enum BookmarkStatus{
    case bookmarked
    case notBookmarked
}

//MARK: -  Profile button
enum ProfileButton{
    case posts
    case bookmarks
}

//MARK: - TabBar Enums
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
