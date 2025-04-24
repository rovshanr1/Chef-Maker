//
//  SearchBarView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 24.04.25.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var txt: String
    @Binding var show: Bool
    var namespace: Namespace.ID
    
    @State private var navigateToFilterView: Bool = false
    
    
    var body: some View {
        NavigationStack {
            HStack(spacing: 20){
                HStack{
                    Image("search-normal")
                        .matchedGeometryEffect(id: "searchLogo", in: namespace, isSource: !show )
                    
                    TextField("Search", text: $txt)
                    
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.3), lineWidth:1)
                )
                
                Button(action:{
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    withAnimation{
                        navigateToFilterView = true
                    }
                }){
                    Image("Filter")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
            }
            .padding(.horizontal)
            .navigationDestination(isPresented: $navigateToFilterView){
                FilterView()
            }
            
        }
    }
}

struct SearchView_Preview: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        SearchBarView(txt: .constant(""), show: .constant(true), namespace: namespace)
    }
}
