//
//  MatchView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 18.04.25.
//

import SwiftUI

struct MatchView: View {
    @Binding var text: String
    @Namespace var namespace
    @State var show: Bool = false
    
    @State var showFilter = false
    @FocusState private var focus: Bool

    var body: some View {
        if !show{
            HStack(spacing: 20){
                HStack{
                    Image("search-normal")
                    TextField("Search", text: $text)
                        .disabled(true)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                         .fill(Color(.systemBackground))
                         .overlay(
                             RoundedRectangle(cornerRadius: 12)
                                 .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                         )
                )
                .padding(.horizontal)
                .matchedGeometryEffect(id: "Search", in: namespace)
                .onTapGesture{
                    withAnimation{
                        show = true
                    }
                }
            }
           
          
            
        } else{
            
        }
    }
}

#Preview{
    MatchView(text: .constant(""))
}
