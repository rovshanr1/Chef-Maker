//
//  HideKeyboardExtension.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 09.04.25.
//

import SwiftUI


extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


