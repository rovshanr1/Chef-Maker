//
//  SearchGridView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 26.04.25.
//

import SwiftUI

struct SearchGridView: View {
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    @Previewable @Namespace var namespace
    @Previewable @State var show = false

    SearchView(namespace: namespace, show: $show)
}
