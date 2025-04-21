//
//  RefreshableScrollView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 21.04.25.
//

import SwiftUI

struct RefreshableScrollView<Content:View>: View {
    let onRefresh: () async -> Void
    let content: () -> Content
    
    init(onRefresh: @escaping () async -> Void, @ViewBuilder content: @escaping () -> Content){
        self.onRefresh = onRefresh
        self.content = content
    }
    
    var body: some View {
        ScrollView{
            content()
               
        }
        .refreshable {
            await onRefresh()
        }
    
    }
}


