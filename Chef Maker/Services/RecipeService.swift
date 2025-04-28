//
//  RecipeService.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 07.04.25.
//

import Foundation

protocol RecipeServiceProtocol {
    func fetchRecipes(for category: Category) async throws -> [Recipe]
    func fetchFeaturedRecipes() async throws -> [Recipe]
}


class RecipeService: RecipeServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let baseURL = "https://api.spoonacular.com/recipes/complexSearch"
    private let cache = CacheManager.shared
    
    init(networService: NetworkServiceProtocol = BaseNetworkService()) {
        self.networkService = networService
    }
    
    private var apiKey: String {
           Bundle.main.infoDictionary?["API_KEY"] as? String ?? ""
       }
    
    
    func fetchFeaturedRecipes() async throws -> [Recipe] {
        if let cachedData = try await cache.getFeaturedRecipes() {
            return cachedData
        }
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.queryItems = [
        URLQueryItem(name: "apiKey", value: apiKey),
        URLQueryItem(name: "number", value: "10"),
        URLQueryItem(name: "addRecipeInformation", value: "true"),
        URLQueryItem(name: "sortDirection", value: "desc"),
        URLQueryItem(name: "addRecipeNutrition", value: "true"),
        URLQueryItem(name: "random", value: "true")
    ]
        
        guard let url = urlComponents?.url else {
                    throw NetworkError.invalidUrl
                }
                
                let response: SpoonacularResponse = try await networkService.fetchData(from: url)
                let sortedRecipes = response.results.sorted { $0.aggregateLikes > $1.aggregateLikes }
                
                
                try await cache.saveFeaturedRecipes(recipes: sortedRecipes)
                
                return sortedRecipes
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
        let response: SpoonacularResponse = try await networkService.fetchData(from: url)
        return response.results
    }
}

