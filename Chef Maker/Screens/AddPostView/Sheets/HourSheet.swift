//
//  CookingTimeSheet.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 18.05.25.
//

import SwiftUI

struct HourSheet: View {
    @Binding var hour: Int
    @Binding var minute: Int
    
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        HStack {
            Picker("Hour", selection: $hour){
                ForEach(0..<24, id: \.self){ hour in
                    Text("\(hour)h")
                        .foregroundStyle(AppColors.adaptiveText(for: colorScheme))
                }
            }
            .pickerStyle(.wheel)
            .foregroundStyle(.gray)
            
            Picker("Minute", selection: $minute){
                ForEach(1..<59, id: \.self){ minute in
                    Text("\(minute)m")
                        .foregroundStyle(AppColors.adaptiveText(for: colorScheme))
                }
            }
            .pickerStyle(.inline)
            .foregroundStyle(.gray)
        }
    }
}

#Preview {
    PostTitleView(appState: AppState(), selectedImage: UIImage())
        .environmentObject(AppState())
}
