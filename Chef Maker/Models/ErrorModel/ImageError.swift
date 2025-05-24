//
//  ImageError.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 04.05.25.
//

import Foundation

enum ImageError: LocalizedError {
    case invalidImageData
    case failedToDelete
    case invalidURL
    case invalidRequestBody
    case invalidResponse
    case unauthorized
    case fileNotFound
    case invalidFileId
    case serverError
    case backendError(message: String)
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidImageData:
            return "Invalid image data"
        case .failedToDelete:
            return "Failed to delete file"
        case .invalidURL:
            return "Invalid URL"
        case .invalidRequestBody:
            return "Invalid request body"
        case .invalidResponse:
            return "Invalid server response"
        case .unauthorized:
            return "Unauthorized access"
        case .fileNotFound:
            return "File not found"
        case .serverError:
            return "Server error"
        case .invalidFileId:
            return "Invalid file id"
        case .backendError(let message):
            return message
        case .unknown(let error):
            return "Unknown error: \(error)"
        }
    }
}
