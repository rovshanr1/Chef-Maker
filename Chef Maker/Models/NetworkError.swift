//
//  SearchError.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 07.04.25.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidUrl
    case invalidResponse
    case decodingError(Error)
    case networkError(Error)
    case missingAPIKey
    
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .decodingError:
            return "Error processing data"
        case .networkError:
            return "Network connection error"
        case .missingAPIKey:
            return "API key not found"
        }
    }
}

