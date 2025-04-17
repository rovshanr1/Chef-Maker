//
//  RecipeService.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 07.04.25.
//

import Foundation

protocol RecipeServiceProtocol {
    func fetchRecipes(for category: Category) async throws -> [Recipe]
}


class RecipeService: RecipeServiceProtocol {
    private let networService: NetworkServiceProtocol
    private let baseURL = "https://api.spoonacular.com/recipes/complexSearch"
    
    init(networService: NetworkServiceProtocol = BaseNetworkService()) {
        self.networService = networService
    }
    
    private var apiKey: String {
           Bundle.main.infoDictionary?["API_KEY"] as? String ?? ""
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
            throw NetworkError.invalidUrl
        }
        let response: SpoonacularResponse = try await networService.fetchData(from: url)
        return response.results
    }
}
