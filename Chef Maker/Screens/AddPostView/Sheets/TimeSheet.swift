//
//  CookingTimeSheet.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 18.05.25.
//

import SwiftUI

struct TimeSheet: View {
    
    //Bindings
    @Binding var hour: Int
    @Binding var minute: Int
    
    //Enviroment
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack{
                VStack {
                    Text("Hours")
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
                }
                
                VStack {
                    Text("Minutes")
                        .font(.custom("Poppins-Medium", size: 16))
                        .foregroundStyle(AppColors.adaptiveText(for: colorScheme))
                        .padding([.top, .horizontal])
                    
                    Picker("Minutes", selection: $minute){
                        ForEach(0..<60, id: \.self){ minute in
                            Text("\(minute)m")
                                .foregroundStyle(AppColors.adaptiveText(for: colorScheme))
                        }
                    }
                    .pickerStyle(.wheel)
                    .foregroundStyle(.gray)
                }
            }
            
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
    TimeSheet(hour: .constant(Array(0..<24).first ?? 0), minute: .constant(Array(0..<60).first ?? 0))
}
