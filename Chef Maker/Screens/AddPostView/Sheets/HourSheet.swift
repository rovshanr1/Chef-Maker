//
//  CookingTimeSheet.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 18.05.25.
//

import SwiftUI

struct HourSheet: View {
    @Binding var hour: Int
  
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Text("Hour!")
                .font(.custom("Poppins-Medium", size: 16))
                .foregroundStyle(AppColors.adaptiveText(for: colorScheme))
                .padding([.top, .horizontal])
            
            Picker("Hour", selection: $hour){
                ForEach(0..<24, id: \.self){ hour in
                    Text("\(hour)h")
                        .foregroundStyle(AppColors.adaptiveText(for: colorScheme))
                }
            }
            .pickerStyle(.wheel)
            .foregroundStyle(.gray)
            
            Button(action: {
                dismiss()
            }){
                Text("Done")
                    .font(.custom("Poppins-Medium", size: 16))
            }
            .padding()
            .foregroundStyle(AppColors.adaptiveText(for: colorScheme))
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(AppColors.filedFilterButtonColor)
                    
            )
        }
    }
}

#Preview {
//    PostTitleView(appState: AppState(), selectedImage: UIImage())
//        .environmentObject(AppState())
    HourSheet(hour: .constant(Array(0..<24).first ?? 0))
}
