//
//  CacheError.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 07.04.25.
//

import Foundation

enum CacheError: Error {
    case encodingError
    case decodingError
    
    var localizedDescription: String {
        switch self {
        case .encodingError:
            return "Veri cache'e kaydedilirken hata oluştu"
        case .decodingError:
            return "Cache'den veri okunurken hata oluştu"
        }
    }
}
