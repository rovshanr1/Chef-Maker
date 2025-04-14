//
//
//  Chef Maker
//
//  Created by Rovshan Rasulov on 06.04.25.
//

import Foundation

protocol RecipeServiceProtocol {
    func fetchRecipes(for category: Category) async throws -> [Recipe]
}

protocol DiscoveryViewModelProtocol: BaseViewModelProtocol {
    var selectedCategories: Set<Category> { get set }
    var searchText: String { get set }
    var filteredCategories: [Category] { get }
    
    func toggleCategory(_ category: Category)
    func clearSelectedCategories()
    func isSelected(_ category: Category) -> Bool
}


class DiscoveryViewViewModel: BaseViewModel<Recipe>, DiscoveryViewModelProtocol {
    @Published var selectedCategories: Set<Category> = []
    @Published var searchText: String = ""
    
    private var allCategories: [Category] = Category.allCases.sorted { $0.rawValue < $1.rawValue }
    
    var filteredCategories: [Category] {
        searchText.isEmpty ? allCategories : allCategories.filter { $0.rawValue.localizedCaseInsensitiveContains(searchText) }
    }
    
    func fetchRecipes(for category: Category) async {
        isLoading = true
        error = nil
        
        do {
            let url = try createURL(category: category)
            let response: SpoonacularResponse = try await networkService.fetchData(from: url)
            data = response.results
        } catch {
            self.error = error as? NetworkError ?? .networkError(error)
        }
        
        isLoading = false
    }
    
    private func createURL(category: Category) throws -> URL {
        var components = URLComponents(string: "https://api.spoonacular.com/recipes/complexSearch")
        components?.queryItems = [
            URLQueryItem(name: "apiKey", value: apiKey),
            URLQueryItem(name: "query", value: category.rawValue),
            URLQueryItem(name: "number", value: "20"),
            URLQueryItem(name: "addRecipeNutrition", value: "true")
        ]
        
        guard let url = components?.url else {
            throw NetworkError.invalidUrl
        }
        
        return url
    }
    
    func toggleCategory(_ category: Category) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
        
        Task {
            await fetchRecipes(for: category)
        }
    }
    
    func clearSelectedCategories() {
        selectedCategories.removeAll()
        data.removeAll()
    }
    
    func isSelected(_ category: Category) -> Bool {
        selectedCategories.contains(category)
    }
}

