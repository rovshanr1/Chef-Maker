//
//  MinuteSheet.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 18.05.25.
//

import SwiftUI

struct MinuteSheet: View {
    @Binding var minute: Int
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack{
            Text("Minute!")
                .font(.custom("Poppins-Medium", size: 16))
            
            Picker("Minute", selection: $minute){
                ForEach(0..<60, id: \.self){ minute in
                    Text("\(minute)m")
                        .foregroundStyle(AppColors.adaptiveText(for: colorScheme))
                }
            }
            .pickerStyle(.inline)
            .foregroundStyle(.gray)
            
            Button(action: {
                dismiss()
            }){
                Text("Done")
                    .foregroundStyle(AppColors.adaptiveText(for: colorScheme))
                    .font(.custom("Poppins-Medium", size: 16))
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(AppColors.filedFilterButtonColor)
            )
        }
    }
}

#Preview {
    MinuteSheet(minute: .constant(0))
}
