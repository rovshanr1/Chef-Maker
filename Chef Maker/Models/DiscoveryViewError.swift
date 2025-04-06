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
            return "Geçersiz URL: API isteği için URL oluşturulamadı"
        case .invalidResponse:
            return "Geçersiz Yanıt: Sunucudan beklenmeyen bir yanıt alındı"
        case .networkError(let error):
            return "Ağ Hatası: \(error.localizedDescription)"
        case .decodingError(let error):
            return "Veri Çözümleme Hatası: \(error.localizedDescription)"
        case .missingAPIKey:
            return "API Anahtarı Eksik: Lütfen Secrets.xcconfig dosyasında API anahtarını tanımlayın"
        }
    }
}
