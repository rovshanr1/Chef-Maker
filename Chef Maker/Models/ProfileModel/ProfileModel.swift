//
//  ProfileModel.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 13.04.25.
//

import Foundation


struct ProfileModel: Identifiable, Codable{
    var id = UUID()
    var userName: String
    var email: String
    var timeStamp: Date
}
