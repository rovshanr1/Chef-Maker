//
//  SearchBarView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 24.04.25.
//

import SwiftUI

struct SearchBarView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        HStack{
            HStack{
                Image("search-normal")
                TextField("Search", text: .constant(""))
                    .disabled(true)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(AppColors.adaptiveMainTabView(for: colorScheme))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
            )
            .padding(.horizontal)
        }
    }
}


#Preview{
    SearchBarView()
        .environmentObject(AppState())
}
