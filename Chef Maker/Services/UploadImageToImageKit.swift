//
//  UploadImageToImageKit.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 04.05.25.
//

import UIKit

struct BackendUploadResponse: Decodable {
    let url: String
}


        struct ImageUploadService {
            static func uploadImageToBackend(image: UIImage, fileName: String) async throws -> String {
                guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                    throw ImageError.invalidImageData
                }
                
                let base64String = imageData.base64EncodedString()
                let url = URL(string: "https://chef-maker-back-bbeksrye8-rovshans-projects-4e30a7e2.vercel.app/api/upload")!
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let body: [String: Any] = [
                    "file": base64String,
                    "fileName": fileName
                ]
                request.httpBody = try? JSONSerialization.data(withJSONObject: body)
                
                let (data, _) = try await URLSession.shared.data(for: request)
                let responseString = String(data: data, encoding: .utf8)
                print("Backend cevabı: \(responseString ?? "veri yok")")
                let decoded = try JSONDecoder().decode(BackendUploadResponse.self, from: data)
                print("Backend'den dönen URL: \(decoded.url)")
                return decoded.url
            }
        }
        
    

