//
//  EmptySearchVIew.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 01.05.25.
//

import SwiftUI

struct EmptySearchView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State private var animate = false
    
    var body: some View {
        ZStack{
            AppColors.adaptiveMainTabView(for: colorScheme)
                .ignoresSafeArea()
            VStack(spacing: 16){
                Image("Search")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 300)
                    .opacity(animate ? 1 : 0)
                    .offset(y: animate ? 0 : 20)
                    .animation(.easeInOut(duration: 0.3), value: animate)
                VStack{
                    Text("Nothing’s cooking yet")
                    
                    Text("let’s add a tasty recipe!")
                     
                }
                .font(.custom("Poppins-SemiBold", size: 18))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.horizontal, 24)
            }
        }
        .onAppear{
            animate = true
        }
    }
}

#Preview {
    EmptySearchView()
}
