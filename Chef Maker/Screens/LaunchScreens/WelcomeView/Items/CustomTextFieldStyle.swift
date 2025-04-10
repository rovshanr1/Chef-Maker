//
//  CustomTextFieldStyle.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 09.04.25.
//
import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    @Environment(\.colorScheme) var colorScheme
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.custom("Poppins-Regular", size: 14))
            .padding(.horizontal, 16)
            .frame(height: 55)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(colorScheme == .dark ? AppColors.darkCardBackground : AppColors.lightBackground)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(colorScheme == .dark ? Color.gray.opacity(0.3) : Color(hex: "#D9D9D9"), lineWidth: 1.5)
                }
            )
         
    }
}
