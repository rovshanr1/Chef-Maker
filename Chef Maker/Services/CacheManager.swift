//
//  CacheManager.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 21.04.25.
//

import Foundation
import Kingfisher

actor CacheManager {
    static let shared = CacheManager()
    
    private let defaults = UserDefaults.standard
    private let featuredRecipesKey = "featuredRecipes"
    private let lastUpdateKey = "featuredRecipesLastUpdate"
    private let cacheValidityDuration: TimeInterval = 60
    
    //From kingfisher
     let imageCache: ImageCache = {
        let cache = ImageCache(name: "com.chefmaker.imageCache")
        
        //Memory cache limit (300MB)
        cache.memoryStorage.config.totalCostLimit =  300 * 1024 * 1024
        //Disk cache limit (1GB)
        cache.diskStorage.config.sizeLimit = 1000 * 1024 * 1024
        //Memory cache duration (1H)
        cache.memoryStorage.config.expiration = .seconds(3600)
        //Disk cache duration (7D)
        cache.diskStorage.config.expiration = .days(7)
        
        return cache
    }()
    
   
    
    func shouldRefreshCache() async throws -> Bool {
        let lastUpdate = defaults.double(forKey: lastUpdateKey)
        let currentTime = Date().timeIntervalSince1970
        
        if lastUpdate == 0{
            return true
        }
        
        let shouldRefresh = (currentTime - lastUpdate) >= cacheValidityDuration

        if shouldRefresh {
            clearCache()
            await clearImageCache()
        } else{
         print("ℹ️ Cache is valid")
        }
         return shouldRefresh
    }
    
    func saveFeaturedRecipes(recipes: [Recipe]) async throws {
        guard let encoded = try? JSONEncoder().encode(recipes) else {
            
            throw CacheError.encodingError
        }
        defaults.set(encoded, forKey: featuredRecipesKey)
        defaults.set(Date().timeIntervalSince1970, forKey: lastUpdateKey)
        
        defaults.synchronize()
    }
    
    func getFeaturedRecipes() async throws -> [Recipe]? {
        guard let data = defaults.data(forKey: featuredRecipesKey) else {
            
            return nil
        }
        
        do {
           let decoded = try JSONDecoder().decode([Recipe].self, from: data)
            
            return decoded

        } catch {
            throw CacheError.decodingError
        }
    }
    
//    func getImageCacheStatus() async -> (memorySize: UInt, diskSize: UInt) {
//        let memorySize = memoryItems.reduce(0) { $0 + UInt($1.value.cacheCost) }
//        
//        do{
//            let diskSize = try imageCache.diskStorage.totalSize()
//            return (memorySize, diskSize)
//        }catch{
//            print("Disk size fetching error: \(error.localizedDescription)")
//            return (memorySize, 0)
//        }
//    }
    
    
    func clearImageCache() async {
           imageCache.clearMemoryCache()
        await imageCache.clearDiskCache()
       }
    
    func clearCache() {
        defaults.removeObject(forKey: featuredRecipesKey)
        defaults.removeObject(forKey: lastUpdateKey)
        defaults.synchronize()
    }
}
