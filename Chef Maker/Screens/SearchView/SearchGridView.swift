//
//  SearchGridView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 26.04.25.
//

import SwiftUI

struct SearchGridView: View {
    @ObservedObject var viewModel: SearchViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(spacing: 20){
            HStack{
                Text("Search \($viewModel.data.count) Result")
                    .font(.custom("Poppins-Medium", size: 18))
                    .padding(.leading)
            }
            
            ScrollView{
                LazyVGrid(columns: columns, spacing: 16 ){
                    ForEach(viewModel.data){ recipe in
                        RecipeCardView(recipe: recipe)
                    }
                    
                }
            }
            
        }
        .padding(.top)
        
    }
}

#Preview {
    @Previewable @Namespace var namespace
    @Previewable @State var show = true
    
    SearchView(namespace: namespace, show: $show)
}
