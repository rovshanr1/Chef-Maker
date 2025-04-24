//
//  FilterView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 24.04.25.
//

import SwiftUI

struct FilterView: View {
    @StateObject private var viewModel = SearchObservableObject()
    
    private let columns = Array(repeating: GridItem(.adaptive(minimum: 100)), count: 4)
    
    var body: some View {
       
        
        NavigationStack {
            VStack(alignment: .leading, spacing: 24){
                VStack(alignment: .leading, spacing: 18){
                    Text("Time")
                        .font(.custom("Poppins-Bold", size: 18))
                    HStack {
                        ForEach(TimeFilter.allCases, id: \.self) { filter in
                            FilterButton(
                                title: filter.rawValue.capitalized,
                                symbol: "",
                                showSymbol: false,
                                isSelected: viewModel.isTimeFilterSelected(filter),
                            ){
                                viewModel.togleTimeFilter(filter)
                            }
                            
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 18){
                    Text("Rate")
                        .font(.custom("Poppins-Bold", size: 18))
                    HStack{
                        ForEach(RateFilter.allCases, id: \.self) { rate in
                            FilterButton(
                                title: rate.rawValue.formatted(),
                                symbol: "star.fill",
                                showSymbol: true,
                                isSelected: viewModel.isSelectedRate(rate)){
                                    viewModel.togleRateFilter(rate)
                                }
                            
                        }
                    }
                    
                    
                }
                
                VStack(alignment: .leading, spacing: 18){
                    Text("Category")
                        .font(.custom("Poppins-Bold", size: 18))
                    
                    categoryButons
                    
                    
                }
            }
            .padding(.horizontal)
            .navigationBarBackButtonHidden(true)
        }
        
    }
    
    private var categoryButons: some View {
        
        
            LazyVGrid(columns: columns){
                ForEach(CategoryFilter.allCases, id: \.self) { category in
                    FilterButton(
                        title: category.rawValue.capitalized,
                        symbol: "",
                        showSymbol: false,
                        isSelected: viewModel.categorySelected(category)){
                            viewModel.categoryToggeled(category)
                        }
                    
                }
            }
            
        }
}


#Preview{
    FilterView()
}
