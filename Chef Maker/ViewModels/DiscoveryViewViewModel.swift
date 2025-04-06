//
//
//  Chef Maker
//
//  Created by Rovshan Rasulov on 06.04.25.
//

import Foundation

class DiscoveryViewViewModel: ObservableObject {
  
    @Published var selectedCategories: Set<Category> = []
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    @Published var ingredients: [Ingredient] = []
    @Published var error: DiscoveryViewError?
    
    private var allCategories: [Category] = Category.allCases.sorted { $0.rawValue < $1.rawValue }
    
    //API Configuration
    private let baseURL = "https://api.spoonacular.com/recipes/complexSearch"
    
    //fetch api key
    private var apiKey: String {
        if let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String {
            return apiKey
        }
        
        if let dict = Bundle.main.infoDictionary {
            print(dict)
        }
        return ""
    }
    
    var filteredCategories: [Category] {
        if searchText.isEmpty {
            return allCategories
        }
        return allCategories.filter { $0.rawValue.localizedCaseInsensitiveContains(searchText) }
    }
    
    var selectedCategoriesArray: [Category] {
        Array(selectedCategories).sorted { $0.rawValue < $1.rawValue }
    }
    
    @MainActor
    func fetchIngredients(for category: Category) async {
        isLoading = true
        error = nil
        
        do {
            let ingredients = try await fetchIngredientsFromAPI(category: category)
            self.ingredients = ingredients
        } catch let error as DiscoveryViewError {
            self.error = error
        } catch {
            self.error = .networkError(error)
        }
        
        isLoading = false
    }
    
    private func fetchIngredientsFromAPI(category: Category) async throws -> [Ingredient] {
        var urlComponents = URLComponents(string: baseURL)
        
        // Query parameters
        urlComponents?.queryItems = [
            URLQueryItem(name: "apiKey", value: apiKey),
            URLQueryItem(name: "query", value: category.rawValue),
            URLQueryItem(name: "number", value: "20"),
            URLQueryItem(name: "addRecipeNutrition", value: "true")
        ]
        
        guard let url = urlComponents?.url else {
            throw DiscoveryViewError.invalidUrl
        }
        
        
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw DiscoveryViewError.invalidResponse
        }
        
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw DiscoveryViewError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(SpoonacularResponse.self, from: data)
            return response.results.map { $0.toIngredient() }
        } catch {
            throw DiscoveryViewError.decodingError(error)
        }
    }
    
    // MARK: - Category Methods
    func toggleCategory(_ category: Category) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
        
    
        Task {
            await fetchIngredients(for: category)
        }
    }
    
    func clearSelectedCategories() {
        selectedCategories.removeAll()
        ingredients.removeAll()
    }
    
    func isSelected(_ category: Category) -> Bool {
        selectedCategories.contains(category)
    }
    
    init() {
        if apiKey.isEmpty {
            error = .missingAPIKey
        }
    }
}
