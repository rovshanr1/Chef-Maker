//
//  RecipeService.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 07.04.25.
//

import Foundation


class RecipeService: RecipeServiceProtocol {
    private let baseURL = "https://api.spoonacular.com/recipes/complexSearch"
    
    private var apiKey: String {
        if let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String {
            return apiKey
        }
        return ""
    }
    
    func fetchRecipes(for category: Category) async throws -> [Recipe] {
        var urlComponents = URLComponents(string: baseURL)
        
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
            return try decoder.decode(SpoonacularResponse.self, from: data).results
        } catch {
            throw DiscoveryViewError.decodingError(error)
        }
    }
}
