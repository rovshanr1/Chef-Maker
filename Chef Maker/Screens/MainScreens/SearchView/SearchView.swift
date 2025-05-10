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
    @State var show: Bool = false
    @Binding var showTabbar: Bool
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.adaptiveMainTabView(for: colorScheme)
                    .ignoresSafeArea(edges: .all)
                
                VStack {
                    SearchBarView()
                        .matchedGeometryEffect(id: "Search", in: namespace)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                searchViewModel.searchActive = true
                            }
                        }
                    
                    Spacer()
                }
                
                if searchViewModel.searchActive {
                    RecipeSearchView(namespace: namespace, show: $searchViewModel.searchActive)
                        .onAppear {
                                showTabbar = false
                        }
                        .onDisappear {
                                showTabbar = true
                        }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    SearchView(showTabbar: .constant(true))
        .environmentObject(AppState())
}
