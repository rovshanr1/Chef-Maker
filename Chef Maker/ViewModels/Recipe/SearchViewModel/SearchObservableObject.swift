//
//  SearchObservableObject.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 06.04.25.
//
import Foundation
import Combine

protocol SearchViewModelProtocol: BaseViewModelProtocol {
    var searchText: String { get set }
    func searchRecipes(query: String) async
}


class SearchObservableObject: BaseViewModel<Recipe>, SearchViewModelProtocol {
    @Published var searchText: String = ""
    private var cancellables = Set<AnyCancellable>()
    private let baseURL = "https://api.spoonacular.com/recipes/complexSearch"
    
    override init(networkService: NetworkServiceProtocol = BaseNetworkService()) {
        super.init(networkService: networkService)
        setupSearchSubscription()
    }
    
    private func setupSearchSubscription() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .filter { !$0.isEmpty }
            .sink { [weak self] searchText in
                Task { [weak self] in
                    await self?.searchRecipes(query: searchText)
                }
            }
            .store(in: &cancellables)
    }
    
    func searchRecipes(query: String) async {
        guard !query.isEmpty else {
            data = []
            return
        }
        
        isLoading = true
        error = nil
        
        do {
            let url = try createURL(query: query)
            let response: SpoonacularResponse = try await networkService.fetchData(from: url)
            data = response.results
        } catch {
            self.error = error as? NetworkError ?? .networkError(error)
        }
        
        isLoading = false
    }
    
    private func createURL(query: String) throws -> URL {
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "apiKey", value: apiKey),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "number", value: "20"),
            URLQueryItem(name: "addRecipeNutrition", value: "true")
        ]
        
        guard let url = components?.url else {
            throw NetworkError.invalidUrl
        }
        
        return url
    }
}


