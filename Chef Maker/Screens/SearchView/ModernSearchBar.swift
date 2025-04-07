//
//  ModernSearchView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 07.04.25.
//

import SwiftUI

struct ModernSearchBar: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool
    @State private var isEditing = false
    
    var body: some View {
        HStack(spacing: 12) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .frame(width: 20)
                    .animation(.easeInOut, value: isEditing)
                
                TextField("Search for Recipe...", text: $text)
                    .focused($isFocused)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isEditing = true
                        }
                    }
                
                if !text.isEmpty {
                    Button(action: {
                        text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .frame(width: 20, height: 20)
                    }
                    .transition(.scale)
                }
            }
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isFocused ? Color.blue : Color.clear, lineWidth: 1)
            )
            .animation(.easeInOut(duration: 0.2), value: text)
            
            if isEditing {
                Button("Cancel") {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isEditing = false
                        text = ""
                        isFocused = false
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                      to: nil, from: nil, for: nil)
                    }
                }
                .foregroundColor(.blue)
                .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
    }
}

