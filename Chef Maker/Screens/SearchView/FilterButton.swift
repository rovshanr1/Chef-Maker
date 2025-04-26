//
//  FilterSearchView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 24.04.25.
//

import SwiftUI

struct FilterButton: View {
    let title: String
    let symbol: String
    let showSymbol: Bool
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action){
            HStack(){
                if showSymbol {
                    Image(systemName: symbol)
                        .resizable()
                        .font(.footnote)
                        .frame(width: 12, height: 12)
                    }
                Text(title)
                    .font(.custom("Poppins-Regular", size: 12))
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(isSelected ? Color(AppColors.filedFilterButtonColor) : Color.clear)
            .foregroundStyle(isSelected ? .white : Color(AppColors.emptyFilterButtonColor))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(AppColors.emptyFilterButtonColor), lineWidth: 1)
            )
            .cornerRadius(12)
                
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    
}

#Preview {
    FilterButton(title: "All", symbol: "star.fill", showSymbol: true, isSelected: false, action: {})
}
