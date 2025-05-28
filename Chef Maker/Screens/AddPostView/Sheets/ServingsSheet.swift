//
//  MinuteSheet.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 18.05.25.
//

import SwiftUI

struct ServingsSheet: View {
    @Binding var serving: Int
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack{
            Text("Servings")
                .font(.custom("Poppins-Medium", size: 16))
            
            Picker("Servings", selection: $serving){
                ForEach(1...20, id: \.self){ serving in
                    Text("\(serving) servings")
                        .foregroundStyle(AppColors.adaptiveText(for: colorScheme))
                }
            }
            .pickerStyle(.wheel)
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
    ServingsSheet(serving: .constant(0))
}
