//
//  RefreshableScrollView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 21.04.25.
//

import SwiftUI

struct RefreshableScrollView<Content:View>: View {
    @Binding var isRefreshing: Bool
    let onRefresh: () async -> Void
    let content: () -> Content
    
    init(isRefreshing: Binding<Bool>,onRefresh: @escaping () async -> Void, @ViewBuilder content: @escaping () -> Content){
        _isRefreshing = isRefreshing
        self.onRefresh = onRefresh
        self.content = content
    }
    
    var body: some View {
        ScrollView(showsIndicators: false){
            if isRefreshing {
                ProgressView()
                    .progressViewStyle(.circular)
                    .padding()
            }
            content()
               
        }
        .refreshable {
            isRefreshing = true
            await onRefresh()
            isRefreshing = false 
        }
    
    }
}


