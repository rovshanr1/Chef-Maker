//
//  SearchError.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 07.04.25.
//

import SwiftUI

struct SearchErrorView: View {
    let message: String
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundColor(.red)
            
            Text(message)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}


