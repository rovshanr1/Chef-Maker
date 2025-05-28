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
        let url = URL(string: "http://192.168.1.70:3000/upload")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let body: [String: Any] = [
            "file": base64String,
            "fileName": fileName,
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoded = try JSONDecoder().decode(BackendUploadResponse.self, from: data)
        
        print("URL returned from Backend: \(decoded.url)")
        print("FileId returned from backend: \(String(describing: decoded.fileId))")
        
        return decoded
    }
    
    static func deleteFile(fileId: String, token: String) async throws {
        guard !fileId.isEmpty else {
            throw ImageError.invalidFileId
        }
        
        let url = URL(string: "http://192.168.1.70:3000/delete")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        
        print("DELETE Request URL: \(url)")
        print("FileId to be deleted: \(fileId)")
        
        
        let body: [String: Any] = ["fileId": fileId]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body)
            request.httpBody = jsonData
            
            
            if let bodyString = String(data: jsonData, encoding: .utf8) {
                print("Request Body: \(bodyString)")
            }
        } catch {
            print("JSON Serialization Error: \(error)")
            throw ImageError.invalidRequestBody
        }

    }
    
    
    
}



