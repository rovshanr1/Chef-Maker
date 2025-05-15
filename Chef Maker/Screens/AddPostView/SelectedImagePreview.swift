//
//  SelectedImagePreview.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 15.05.25.
//

import SwiftUI

struct SelectedImagePreview: View {
    @ObservedObject var service: PhotoLibraryManager
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    @Binding var croppedImage: UIImage?
    @State private var geometrySize: CGSize = .zero
    
    var body: some View {
        VStack {
            if let image = service.selectedImage {
                GeometryReader { geometry in
                    ZStack {
                        
                        Rectangle()
                            .foregroundStyle(.gray.opacity(0.2))
                            .frame(width: geometry.size.width, height: 300)
                        
                        
                        Rectangle()
                            .frame(width: geometry.size.width, height: 300)
                        
                        
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width, height: 300)
                            .scaleEffect(scale)
                            .offset(offset)
                            .onAppear {
                                geometrySize = geometry.size
                                autoPositionImage(in: geometry.size)
                            }
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
                                            if let image = service.selectedImage {
                                                croppedImage = cropImage(image, size: geometry.size)
                                            }
                                        },
                                    DragGesture()
                                        .onChanged { value in
                                            let newOffset = CGSize(
                                                width: lastOffset.width + value.translation.width,
                                                height: lastOffset.height + value.translation.height
                                            )
                                            
                                            let maxOffsetX = (geometry.size.width * (scale - 1)) / 2
                                            let maxOffsetY = (300 * (scale - 1)) / 2
                                            
                                            offset = CGSize(
                                                width: min(max(newOffset.width, -maxOffsetX), maxOffsetX),
                                                height: min(max(newOffset.height, -maxOffsetY), maxOffsetY)
                                            )
                                        }
                                        .onEnded { _ in
                                            lastOffset = offset
                                            if let image = service.selectedImage {
                                                croppedImage = cropImage(image, size: geometry.size)
                                            }
                                        }
                                )
                            )
                    }
                    .frame(height: 300)
                    .clipped()
                    .contentShape(Rectangle())
                }
            } else {
                ProgressView("Loading...")
                    .frame(height: 300)
            }
            
            HStack {
                Button(action: {
                    scale = 1.0
                    offset = .zero
                    lastOffset = .zero
                    if let image = service.selectedImage {
                        croppedImage = cropImage(image, size: geometrySize)
                    }
                }) {
                    Image(systemName: "aspectratio")
                }
                .padding()
                .background(
                    Circle()
                        .fill(.ultraThinMaterial)
                        .frame(height: 38)
                )
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding()
    }
    
    private func cropImage(_ image: UIImage, size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: size.width, height: 300))
        
        return renderer.image { context in
            // Kırpma alanını temizle
            UIColor.clear.set()
            context.fill(CGRect(origin: .zero, size: CGSize(width: size.width, height: 300)))
            
            // Görüntüyü çiz
            let drawRect = CGRect(
                x: -offset.width,
                y: -offset.height,
                width: size.width * scale,
                height: 300 * scale
            )
            
            image.draw(in: drawRect)
        }
    }
        
    private func autoPositionImage(in containerSize: CGSize) {
        guard let image = service.selectedImage else { return }
        
        let imageAspectRatio = image.size.width / image.size.height
        let containerAspectRatio = containerSize.width / 300
        
        if imageAspectRatio > containerAspectRatio {
            
            scale = 1.0
            offset = .zero
        } else {
            
            let newScale = containerSize.width / image.size.width
            scale = newScale
            
            let scaledHeight = image.size.height * newScale
            let verticalOffset = (scaledHeight - 300) / 2
            offset = CGSize(width: 0, height: -verticalOffset)
        }
        
        lastOffset = offset
    }
}


#Preview {
    PostView()
        .environmentObject(AppState())
}
