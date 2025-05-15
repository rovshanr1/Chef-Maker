//
//  MainTabView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 01.05.25.
//

import SwiftUI


struct TabBarView: View {
    @Binding var index: Int
    @Binding var showPostView: Bool 
    
    
    @Environment(\.colorScheme) var colorSheme
    var body: some View {
        
        ZStack {
            HStack {
                
                Button(action: {
                    withAnimation{
                        self.index = 0
                    }
                    
                }) {
                    Image(systemName: "house")
                        .font(.headline)
                    
                }
                .foregroundStyle(AppColors.adaptiveText(for: colorSheme).opacity(self.index == 0 ? 1 : 0.2))
                
                Spacer(minLength: 0)
                
                Button(action: {
                    withAnimation{
                        self.index = 1
                    }
                }) {
                    Image(systemName: "magnifyingglass")
                        .font(.headline)
                }
                .foregroundStyle(AppColors.adaptiveText(for: colorSheme).opacity(self.index == 1 ? 1 : 0.2))
                .offset(x: 10)
                
                Spacer(minLength: 0)
                
                Button(action: {
                    showPostView = true
                }){
                    Image(systemName: "plus")
                        .font(.headline)
                        .foregroundStyle(.white)
                }
                .padding()
                .background(
                    Circle()
                        .foregroundStyle(AppColors.filedFilterButtonColor)
                )
                .offset(y: -20)
               
                Spacer(minLength: 0)
                
                Button(action: {
                    withAnimation{
                        self.index = 2
                    }
                }) {
                    Image(systemName: "bell")
                        .font(.headline)
                }
                .foregroundStyle(AppColors.adaptiveText(for: colorSheme).opacity(self.index == 2 ? 1 : 0.2))
                .offset(x: -10)
                
                Spacer(minLength: 0)
                
                
                Button(action: {
                    withAnimation{
                        self.index = 3
                    }
                }) {
                    Image(systemName: "person")
                        .font(.headline)
                }
                .foregroundStyle(AppColors.adaptiveText(for: colorSheme).opacity(self.index == 3 ? 1 : 0.2))
            }
            .padding(.horizontal, 35)
            .padding(.top, 30)
            .background(
                AppColors.adaptiveCardBackground(for: colorSheme)
                    .clipShape(
                        CShape()
                    )
                    .ignoresSafeArea()
            )
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
       
        

    }
}

struct CShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path{path in
        
            path.move(to: CGPoint(x: 0, y: 35))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 35))
            
            path.addArc(center: CGPoint(x: (rect.width / 2) + 3, y: 35), radius: 30 , startAngle: .zero, endAngle: .degrees(180), clockwise: false)
        }
    }
    
    
}

#Preview {
    MainTabView()
        .environmentObject(AppState())
}
