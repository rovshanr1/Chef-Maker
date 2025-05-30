//
//  FollowAction.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 10.05.25.
//

import Foundation


enum FollowAction{
    case follow
    case unfollow
}

struct FollowStatus{
    let isFollowing: Bool
    let timeStamp: Date?
    let status: String?
}
