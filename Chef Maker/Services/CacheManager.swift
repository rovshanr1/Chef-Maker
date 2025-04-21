//
//  CacheManager.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 21.04.25.
//

import Foundation

actor CacheManager {
    static let shared = CacheManager()
    
    private let defaults = UserDefaults.standard
    private let featuredRecipesKey = "featuredRecipes"
    private let lastUpdateKey = "featuredRecipesLastUpdate"
    private let cacheValidityDuration: TimeInterval = 60
    
    
    
    func shouldRefreshCache() async throws -> Bool {
        let lastUpdate = defaults.double(forKey: lastUpdateKey)
        let currentTime = Date().timeIntervalSince1970
        let shouldRefresh = (currentTime - lastUpdate) >= cacheValidityDuration
        
        if shouldRefresh{
            print("cache expired")
            clearCache()
        }
        
        return shouldRefresh
    }
    
    func saveFeaturedRecipes(recipes: [FeaturedModel]) async throws {
        guard let encoded = try? JSONEncoder().encode(recipes) else {
            print("❌ Failed to encode recipes")
            throw CacheError.encodingError
        }
        defaults.set(encoded, forKey: featuredRecipesKey)
        defaults.set(Date().timeIntervalSince1970, forKey: lastUpdateKey)
        
        defaults.synchronize()
            
            print("✅ Caching \(recipes.count) recipes")
    }
    
    func getFeaturedRecipes() async throws -> [FeaturedModel]? {
        guard let data = defaults.data(forKey: featuredRecipesKey) else {
            print("❌ No cached data found.")
            return nil
        }
        
        do {
           let decoded = try JSONDecoder().decode([FeaturedModel].self, from: data)
            print("✅ Decoded from cache: \(decoded.count) items")
            return decoded

        } catch {
            print("❌ Failed to decode cached data: \(error.localizedDescription)")

            throw CacheError.decodingError
        }
    }    
    func clearCache() {
        defaults.removeObject(forKey: featuredRecipesKey)
        defaults.removeObject(forKey: lastUpdateKey)
        defaults.synchronize()
    }
}
