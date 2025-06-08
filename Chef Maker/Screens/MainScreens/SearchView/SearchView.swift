//
//  SearchView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 08.05.25.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var searchViewModel = SearchViewModel()
    @Namespace var namespace
    @Binding var showTabbar: Bool
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appsBackground
                    .ignoresSafeArea(edges: .all)
                
                VStack {
                    SearchBarView()
                        .matchedGeometryEffect(id: "Search", in: namespace, isSource: !searchViewModel.searchActive)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                searchViewModel.searchActive = true
                            }
                        }
                    
                    Spacer()
                }
                
               
                

            }
            .overlay{
                if searchViewModel.searchActive {
                    RecipeSearchView(namespace: namespace, show: $searchViewModel.searchActive, viewModel: searchViewModel)
                        .onAppear {
                            showTabbar = false
                        }
                        .onDisappear {
                            showTabbar = true
                        }
                }
            }
            .onTapGesture {
                hideKeyboard()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    SearchView(showTabbar: .constant(true))
        .environmentObject(AppState())
}
