//
//  IngredientsSection.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 29.05.25.
//

import SwiftUI

struct IngredientsSection: View {
    @ObservedObject var viewModel: PostViewModel
    
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 16){
                
                maindTextField()
             
                selectedIngredients()
                
                Button(action: {
                    viewModel.addCustomIngredient()
                }){
                    Text("Ingredient +")
                        .font(.custom("Poppins-Bold", size: 14))
                        .foregroundStyle(AppColors.filedFilterButtonColor)
                }
                .padding()
            }
            .padding(.horizontal)
            .padding(.bottom, 4)
            .environment(\.editMode, .constant(.active))
            
            if !viewModel.filteredIngredients.isEmpty{
                searchResults()
                    .offset(y: 90)
            }
        }
    }
    
    
    @ViewBuilder
    func maindTextField() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Ingredients.")
                .font(.custom("Poppins-Bold", size: 18))
            
            TextField("Add new ingredient..", text: $viewModel.searchIngredient)
                .padding()
                .autocorrectionDisabled(true)
                .onChange(of: viewModel.searchIngredient) { oldValue, newValue in
                    viewModel.searchIngredients()
                }
                .background{
                    RoundedRectangle(cornerRadius: 8)
                    .stroke(
                        .ultraThinMaterial,
                        style: StrokeStyle(lineWidth: 2)
                    )
                }
        }
    }
    
    @ViewBuilder
    func searchResults() -> some View {
            ScrollView {
                VStack() {
                    ForEach(viewModel.filteredIngredients) { ingredient in
                        Button(action: {
                            viewModel.selectIngredient(ingredient: ingredient)
                        }) {
                            Text(ingredient.name)
                                .foregroundStyle(AppColors.adaptiveText(for: colorScheme))
                            
                        }
                        .padding(.horizontal)
                        .padding(.top, 4)
                        
                    }
                    
                }
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.ultraThinMaterial)
                        

                )
                .cornerRadius(8)
            }
            .frame(maxWidth: .infinity ,maxHeight: 80, alignment: .leading)
            
    }
    
    @ViewBuilder
    func selectedIngredients() -> some View {
        ForEach($viewModel.ingredients){ $ingredinet in
            HStack(spacing: 12){
                TextField("Ingredient Name", text: $ingredinet.name)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(
                                .ultraThinMaterial,
                                style: StrokeStyle(lineWidth: 2)
                            )
                    )
                
                TextField("Amount", text: $ingredinet.quantity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(
                                .ultraThinMaterial,
                                style: StrokeStyle(lineWidth: 2)
                            )
                    )
                    .frame(width: 100)

            }
        }
        .onMove(perform: viewModel.moveIngredient)
        .onDelete(perform: viewModel.removeIngredient)
    }
}

#Preview {
    PostDetailsView(appState: AppState(), selectedImage: UIImage())
}
