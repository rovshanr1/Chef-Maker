import Foundation
import Combine

@MainActor
protocol FeatureViewModelProtocol: BaseViewModelProtocol{
    func loadFeaturedRecipes() async
    func refreshFeaturedRecipes()
}

@MainActor
final class FeaturedViewModel: BaseViewModel<FeaturedModel> {
    private let recipeService: RecipeServiceProtocol
    private let cache: CacheManager

    init(recipeService: RecipeServiceProtocol = RecipeService()) {
        self.recipeService = recipeService
        self.cache = CacheManager.shared
        super.init()
    }
    
    func loadFeaturedRecipes() async {
        guard !isLoading else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            if try await cache.shouldRefreshCache() {
                let newData = try await recipeService.fetchFeaturedRecipes()
                try await cache.saveFeaturedRecipes(recipes: newData)
                self.data = newData
            } else if let cachedData = try await cache.getFeaturedRecipes() {
                self.data = cachedData
            } else {
                let newData = try await recipeService.fetchFeaturedRecipes()
                try await cache.saveFeaturedRecipes(recipes: newData)
                self.data = newData
            }
        } catch {
            self.error = error as? NetworkError ?? .unknown(error)
        }
    }
    
    
    
    func refreshFeaturedRecipes() {
        Task {
            await loadFeaturedRecipes()
        }
    }
    
    func forceRefresh() async {
      isLoading = true
        defer { isLoading = false}
        
        do{
            await cache.clearCache()
            
            let newData = try await recipeService.fetchFeaturedRecipes()
            try await cache.saveFeaturedRecipes(recipes: newData)
            self.data = newData
        }catch{
            self.error = error as? NetworkError ?? .unknown(error)
        }
        
    }
}





extension FeaturedModel {
    var shortTitle: String {
        if title.count > 50 {
            return String(title.prefix(47)) + "..."
        } else {
            return title
        }
    }
}
