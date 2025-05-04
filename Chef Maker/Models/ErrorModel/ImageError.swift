//
//  ImageError.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 04.05.25.
//

import Foundation

enum ImageError: Error, LocalizedError{
    case invalidImageData
    case invalidResponse
    case serverError(statusCode: Int)
    case decodingError
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidImageData:
            return "Invalid image data"
        case .invalidResponse:
            return "Invalid HTTP response"
        case .serverError(statusCode: let code):
            return "Server error: \(code)"
        case .decodingError:
            return "Error decoding image data"
        case .unknown(let error):
            return "Unknown error: \(error)"
        }
    }
}
