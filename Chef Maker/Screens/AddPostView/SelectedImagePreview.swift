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
    @State private var geometrySize: CGSize = .zero
    
    @State private var isInitialPositioned = false

    @Binding var croppedImage: UIImage?
    @Binding var finalScale: CGFloat
    @Binding var finalOffset: CGSize

    
    var body: some View {
        VStack {
            if let image = service.selectedImage {
                GeometryReader { geometry in
                    ZStack {
                        Rectangle()
                            .foregroundStyle(.gray.opacity(0.2))
                            .frame(width: geometry.size.width, height: 300)

                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: geometry.size.width, maxHeight: 300)
                            .scaleEffect(scale)
                            .offset(offset)
                            .onAppear {
                                geometrySize = geometry.size
                                if !isInitialPositioned {
                                    autoPositionImage(in: geometry.size)
                                    isInitialPositioned = true
                                }
                                
                                if croppedImage == nil {
                                    croppedImage = cropImage(image, in: geometry.size, scale: scale, offset: offset)
                                }
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
                                            finalScale = scale
                                            finalOffset = offset

                                            if let image = service.selectedImage {
                                                croppedImage = cropImage(image, in: geometry.size, scale: scale, offset: offset)
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
                                            lastScale = 1.0
                                            finalScale = scale
                                            finalOffset = offset
                                            lastOffset = offset

                                            if let image = service.selectedImage {
                                                croppedImage = cropImage(image, in: geometry.size, scale: scale, offset: offset)
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
                    isInitialPositioned = false
                    if let image = service.selectedImage {
                        croppedImage = cropImage(image, in: geometrySize, scale: scale, offset: offset)
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

    func cropImage(_ image: UIImage, in containerSize: CGSize, scale: CGFloat, offset: CGSize) -> UIImage? {
        let cropWidth = containerSize.width / scale
        let cropHeight = 300 / scale

        var originX = ((image.size.width - cropWidth) / 2) - (offset.width / scale)
        var originY = ((image.size.height - cropHeight) / 2) - (offset.height / scale)

        
        originX = max(0, min(originX, image.size.width - cropWidth))
        originY = max(0, min(originY, image.size.height - cropHeight))

        let cropRect = CGRect(x: originX, y: originY, width: cropWidth, height: cropHeight)

        guard let cgImage = image.cgImage?.cropping(to: cropRect) else {
            return nil
        }

        return UIImage(cgImage: cgImage, scale: image.scale, orientation: image.imageOrientation)
    }

    private func autoPositionImage(in containerSize: CGSize) {
        scale = 1.0
        offset = .zero
        lastOffset = .zero
    }
}



#Preview {
    PostView()
        .environmentObject(AppState())
}
