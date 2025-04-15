import Foundation
import Combine

@MainActor
final class FeaturedViewModel: BaseViewModel<FeaturedModel> {
    private let baseURL = "https://api.spoonacular.com/recipes"
    private let cache = CacheManager.shared
    
    override init(networkService: NetworkServiceProtocol = BaseNetworkService()) {
        super.init(networkService: networkService)
        Task {
            await loadFeaturedRecipes()
        }
    }
    
    func loadFeaturedRecipes() async {
        isLoading = true
        error = nil
        
        do {
            if let cachedData = try await cache.getFeaturedRecipes() {
                self.data = cachedData
                isLoading = false
                return
            }
            
            
            let endpoint = "\(baseURL)/complexSearch"
            let queryParams = [
                "apiKey": apiKey,
                "number": "10",
                "addRecipeInformation": "true",
                "sort": "popularity",
                "sortDirection": "desc",
                "fillIngredients": "true",
                "addRecipeNutrition": "true"
            ]
            
            let queryString = queryParams.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
            guard let url = URL(string: "\(endpoint)?\(queryString)") else {
                throw NetworkError.invalidUrl
            }
            
            let response: SpoonacularFeaturedResponse = try await networkService.fetchData(from: url)
            
            
            let sortedRecipes = response.recipes.sorted { $0.aggregateLikes > $1.aggregateLikes }
            self.data = sortedRecipes
            
            try await cache.saveFeaturedRecipes(recipes: sortedRecipes)
            
            isLoading = false
        } catch {
            isLoading = false
            if let networkError = error as? NetworkError {
                self.error = networkError
            } else {
                self.error = .unknown(error)
            }
        }
    }
    
    func refreshFeaturedRecipes() {
        Task {
            do {
                let shouldRefresh = try await cache.shouldRefreshFeaturedRecipes()
                if shouldRefresh {
                    await loadFeaturedRecipes()
                }
            } catch {
                await loadFeaturedRecipes()
            }
        }
    }
}

// MARK: - Cache Manager
actor CacheManager {
    static let shared = CacheManager()
    
    private let defaults = UserDefaults.standard
    private let featuredRecipesKey = "featuredRecipes"
    private let lastUpdateKey = "featuredRecipesLastUpdate"
    private let cacheValidityDuration: TimeInterval = 24 * 60 * 60 
    
    private init() {}
    
    func saveFeaturedRecipes(recipes: [FeaturedModel]) async throws {
        guard let encoded = try? JSONEncoder().encode(recipes) else {
            throw CacheError.encodingError
        }
        
        defaults.set(encoded, forKey: featuredRecipesKey)
        defaults.set(Date().timeIntervalSince1970, forKey: lastUpdateKey)
    }
    
    func getFeaturedRecipes() async throws -> [FeaturedModel]? {
        guard let data = defaults.data(forKey: featuredRecipesKey) else {
            return nil
        }
        
        do {
            return try JSONDecoder().decode([FeaturedModel].self, from: data)
        } catch {
            throw CacheError.decodingError
        }
    }
    
    func shouldRefreshFeaturedRecipes() async throws -> Bool {
        let lastUpdate = defaults.double(forKey: lastUpdateKey)
        let currentTime = Date().timeIntervalSince1970
        return (currentTime - lastUpdate) >= cacheValidityDuration
    }
    
    func clearCache() {
        defaults.removeObject(forKey: featuredRecipesKey)
        defaults.removeObject(forKey: lastUpdateKey)
    }
}

