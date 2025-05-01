//
//  ShowCategoryButton.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 18.04.25.
//

import SwiftUI

struct ShowCategoryButton: View {
    @StateObject private var viewModel = DiscoveryViewViewModel()
    var body: some View {
       
            VStack(alignment: .leading, spacing: 16) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(viewModel.filteredCategories, id: \.self) { category in
                            CategoryButton(
                                title: category.rawValue,
                                emoji: category.emoji,
                                isSelected: viewModel.isSelected(category)
                            ) {
                                viewModel.toggleCategory(category)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }


#Preview {
    ShowCategoryButton()
}
