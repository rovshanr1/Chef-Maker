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
        guard !isLoading else {
            print("i'm called")
            return }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            if let cachedData = try await cache.getFeaturedRecipes() {
                self.data = cachedData
                return
            }
            let newData = try await recipeService.fetchFeaturedRecipes()
            try await cache.saveFeaturedRecipes(recipes: newData)
            
            self.data = newData
            
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
        await cache.clearCache()
        await loadFeaturedRecipes()
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
