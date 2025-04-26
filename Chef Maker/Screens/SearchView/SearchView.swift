//
//  SearchView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 25.04.25.
//

import SwiftUI

struct SearchView: View {
    var namespace: Namespace.ID
    @Binding var show: Bool
    
    @State private var showFilter = false
    @FocusState private var focus: Bool
    @StateObject private var viewModel = SearchObservableObject()
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack{
            Button(action:{
                withAnimation(.easeInOut(duration: 0.3)){
                    show = false
                    focus = false
                }
            }){
                Image(systemName: "arrow.backward")
                    .font(.title2)
                    .foregroundStyle(Color(AppColors.filedFilterButtonColor).opacity(0.5))
                    .padding(6)
            }
            
            HStack{
            Image("search-normal")
                TextField("Search", text: $viewModel.searchText)
                    .focused($focus)
                    .disableAutocorrection(true)
                
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(AppColors.adaptiveMainTabView(for: colorScheme))
                 .overlay(
                     RoundedRectangle(cornerRadius: 12)
                        .stroke(AppColors.filedFilterButtonColor.opacity(0.5), lineWidth: 1)
                 )
        )
        .padding(.horizontal)
        .matchedGeometryEffect(id: "Search", in: namespace)
       
            
            Button(action:{
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                showFilter = true
              
            }){
                Image("Filter")
                    .resizable()
                    .foregroundStyle(AppColors.filedFilterButtonColor)
                    .frame(width: 52, height: 52)
                    .padding(6)
            }
        }
        .sheet(isPresented: $showFilter){
            FilterView()
                .presentationDetents([.medium, .large])
                .presentationCornerRadius(12)
        }
        .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                focus = true
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            AppColors.adaptiveMainTabView(for: colorScheme)
        )
        //Grid View
        SearchGridView()
    }
    
   
}

#Preview {
    @Previewable @Namespace var namespace
    DiscoveryView()
}
