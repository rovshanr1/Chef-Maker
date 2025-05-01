//
//  NutrientView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 06.04.25.
//

import SwiftUI

struct NutrientView: View {
  let label: String
  let value: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label)
                .font(.caption2)
                .foregroundColor(.secondary)
            Text(String(format: "%.1fg", value))
                .font(.caption)
                .fontWeight(.medium)
        }
    }
}

