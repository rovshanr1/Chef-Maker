//
//  DiscoveryViewError.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 06.04.25.
//

import Foundation

enum DiscoveryViewError: LocalizedError {
    case invalidUrl
    case invalidResponse
    case networkError(Error)
    case decodingError(Error)
    case missingAPIKey
    
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "Invalid URL: Could not generate URL for API request"
        case .invalidResponse:
            return "Invalid Response: An unexpected response was received from the server"
        case .networkError(let error):
            return "Network Error: \(error.localizedDescription)"
        case .decodingError(let error):
            return "Data Parsing Error: \(error.localizedDescription)"
        case .missingAPIKey:
            return "API Key Missing: Please define API key in Secrets.xcconfig"
        }
    }
}
