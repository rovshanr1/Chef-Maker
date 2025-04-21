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
    
    
    var initials: String{
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: userName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}
