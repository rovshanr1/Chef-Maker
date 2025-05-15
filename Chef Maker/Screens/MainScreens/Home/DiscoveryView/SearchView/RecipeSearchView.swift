//
//  SearchView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 25.04.25.
//

import SwiftUI

struct RecipeSearchView: View {
    var namespace: Namespace.ID
    @Binding var show: Bool
    
    @State private var isFilterPresented = false
    @State private var showFilter = false
    @FocusState private var focus: Bool
    @ObservedObject var viewModel: SearchViewModel
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
                VStack{
                    HStack{
                        Button(action:{
                            withAnimation(.easeInOut(duration: 0.3)){
                                viewModel.searchActive = false
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
                        .matchedGeometryEffect(id: "Search", in: namespace, isSource: viewModel.searchActive)

                        
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
                        FilterView(viewModel: viewModel, showFilter: $showFilter)
                            .presentationDetents([.medium, .large])
                            .presentationCornerRadius(12)
                    }
                    .onAppear(){
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                            focus = true
                        }
                    }
                    .onChange(of: viewModel.searchText) {oldValue, newValue in
                        if newValue.isEmpty{
                            viewModel.data = []
                        }
                    }
                    //Grid View
                    if viewModel.data.isEmpty, viewModel.searchText.isEmpty{
                        EmptySearchView()
                            .ignoresSafeArea(.keyboard, edges: .bottom)
                    }else{
                        RecipeSearchGridView(viewModel: viewModel, namespace: namespace)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(
                    AppColors.adaptiveMainTabView(for: colorScheme)
                        .ignoresSafeArea()
                ).navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    @Previewable @Namespace var namespace
    @Previewable @State var show = true
    
    RecipeSearchView(namespace: namespace, show: $show, viewModel: SearchViewModel())
}
