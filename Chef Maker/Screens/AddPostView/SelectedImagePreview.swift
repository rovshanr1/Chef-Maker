//
//  SelectedImagePreview.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 15.05.25.
//

import SwiftUI


import SwiftUI

struct SelectedImagePreview: View {
    @ObservedObject var service: PhotoLibraryManager
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    var body: some View {
        VStack {
            if let image = service.selectedImage {
                GeometryReader { geometry in
                    ZStack {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: 300)
                            .scaleEffect(scale)
                            .offset(offset)
                            .gesture(
                                SimultaneousGesture(
                                    MagnificationGesture()
                                        .onChanged { value in
                                            let delta = value / lastScale
                                            lastScale = value
                                            scale = min(max(scale * delta, 1), 4)
                                        }
                                        .onEnded { _ in
                                            lastScale = 1.0
                                        },
                                    DragGesture()
                                        .onChanged { value in
                                            offset = CGSize(
                                                width: lastOffset.width + value.translation.width,
                                                height: lastOffset.height + value.translation.height
                                            )
                                        }
                                        .onEnded { _ in
                                            lastOffset = offset
                                        }
                                )
                            )
                    }
                    .frame(height: 300)
                    .clipped()
                }
            } else {
                ProgressView("Loading...")
                    .frame(height: 300)
            }
            
            HStack {
                Button(action:{
                    scale = 1.0
                    offset = .zero
                    lastOffset = .zero
                }){
                    Image(systemName: "aspectratio")
                }
                .padding()
                .background(
                    Circle()
                        .fill(.ultraThinMaterial)
                        .frame(height: 38)
                )
                .foregroundColor(.white)
                .frame(maxWidth:.infinity,alignment: .leading)
                
            }
        }
        .padding()
    }
}


#Preview {
    PostView()
        .environmentObject(AppState())
}
