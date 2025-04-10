//
//  CheckboxToggleStyle.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 10.04.25.
//

import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }){
            HStack{
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                    .foregroundStyle(AppColors.secondaryColor)
                    
            }
        }
    }
}
