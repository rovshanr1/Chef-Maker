//
//  ImageKitService.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 04.05.25.
//

import UIKit

struct BackendUploadResponse: Decodable {
    let url: String
    let fileId: String?
    let name: String?
    let filePath: String?
    let size: Int?
    let type: String?
}

struct ImageKitService {
    static func uploadImageToBackend(image: UIImage, fileName: String, token: String ) async throws -> BackendUploadResponse {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw ImageError.invalidImageData
        }
        let base64String = imageData.base64EncodedString()
 
        let url = URL(string: "https://chef-maker-back-bbeksrye8-rovshans-projects-4e30a7e2.vercel.app/api/upload")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

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
        print("Backend'den dönen fileId: \(String(describing: decoded.fileId))")
        
        return decoded
    }
    
    static func deleteFile(fileId: String, token: String) async throws {
        let url = URL(string: "https://chef-maker-back-bbeksrye8-rovshans-projects-4e30a7e2.vercel.app/api/delete")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        // Debug log: Request details
        print("DELETE Request URL: \(url)")
        print("Authorization header: Bearer \(token)")
        
        let body: [String: Any] = ["fileId": fileId]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ImageError.failedToDelete
        }
        
        // Debug: Response
        print("Response data: \(String(data: data, encoding: .utf8) ?? "No response")")
    }



}



