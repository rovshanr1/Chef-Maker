//
//  FilterView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 24.04.25.
//

import SwiftUI

struct FilterView: View {
    @ObservedObject var viewModel: SearchViewModel
    @Binding var showFilter: Bool
    
    private let columns = Array(repeating: GridItem(.adaptive(minimum: 100)), count: 4)
    
    var body: some View {
            VStack(spacing: 30) {
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
                                    viewModel.selectedTime = filter
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
                
                Button(action: {
                    Task {
                        await viewModel.fetchAllRecipes()
                        showFilter = false
                    }
                }){
                    Text("Filter")
                        .font(.custom("Poppins-Bold", size: 18))
                        .padding()
                        .frame(width: 175)
                }
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(AppColors.filedFilterButtonColor)
                )
                .foregroundStyle(.white)
               
            }
            .padding([.horizontal, .top])
            
        
        
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
    @Previewable @Namespace var namespace
    @Previewable @State var show = false
    
    FilterView(viewModel: SearchViewModel.preview(), showFilter: $show)
}
