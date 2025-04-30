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


class SearchViewModel: BaseViewModel<Recipe>, SearchViewModelProtocol {
    @Published var searchText: String = ""
    @Published var searchActive: Bool = false
    @Published var selectedTime: TimeFilter = .all
    @Published var selectedRate: RateFilter?
    @Published var selectedCategory: Set<CategoryFilter> = []
    private var cancellables = Set<AnyCancellable>()
    private let baseURL = "https://api.spoonacular.com/recipes/complexSearch"
    
    override init(networkService: NetworkServiceProtocol = BaseNetworkService()) {
        super.init(networkService: networkService)
        setupSearchSubscription()
        Task { [weak self] in
            await self?.fetchAllRecipes()
        }
    }
    
    // Mock data initializer for preview
//    static func preview() -> SearchViewModel {
//        let viewModel = SearchViewModel()
//        viewModel.data = MockData.sampleRecipes
//        return viewModel
//    }
    
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
            isLoading = false
            return
        }
        
        isLoading = true
        error = nil
        
        do {
            let url = try createURL(query: query)
            let response: SpoonacularResponse = try await networkService.fetchData(from: url)
            data = await applyAllFilters(to: response.results)
        } catch {
            self.error = error as? NetworkError ?? .networkError(error)
        }
        
        isLoading = false
        
   

    }
    
    func fetchAllRecipes() async {
        isLoading = true; error = nil
        do {
            let url = try createURL(query: "")
            let response: SpoonacularResponse = try await networkService.fetchData(from: url)
            data = await applyAllFilters(to: response.results)
        } catch {
            self.error = error as? NetworkError ?? .networkError(error)
        }
        isLoading = false
    

    }
    
    private func createURL(query: String) throws -> URL {
        var components = URLComponents(string: baseURL)
        var items: [URLQueryItem] = [
            URLQueryItem(name: "apiKey", value: apiKey),
            URLQueryItem(name: "number", value: "20"),
            URLQueryItem(name: "addRecipeNutrition", value: "true")
        ]
        if !query.isEmpty {
            items.append(URLQueryItem(name: "query", value: query))
        }
        
            switch  selectedTime {
            case .newest:
                items.append(URLQueryItem(name: "sort", value: "time"))
            case .oldest:
                items.append(contentsOf: [
                    URLQueryItem(name: "sort", value: "time"),
                    URLQueryItem(name: "sortDirection", value: "asc")
                ])
            case .popularity:
                items.append(URLQueryItem(name: "sort", value: "popularity"))
            default:
                break
            }
            
        
        
        if !selectedCategory.isEmpty {
               let types = selectedCategory
                   .map { $0.rawValue.lowercased() }
                   .joined(separator: ",")
               items.append(URLQueryItem(name: "type", value: types))
           }
        
        
        
      
        components?.queryItems = items
        
        guard let url = components?.url else {
            throw NetworkError.invalidUrl
        }
        
        return url
    }
    
    func applyRateFilter(to recipes: [Recipe]) -> [Recipe] {
        guard let rate = selectedRate else { return recipes }
        return recipes.filter { ($0.spoonacularScore ?? 0) >= Double(rate.rawValue) * 20 }
    }
    
   
    
    func applyAllFilters(to recipes: [Recipe]) async -> [Recipe] {
        var filtered = recipes
        filtered = applyRateFilter(to: filtered)
        
        await fetchAllRecipes()
        
        return filtered
    }
    func isTimeFilterSelected(_ filter: TimeFilter) -> Bool {
        selectedTime == filter  
    }

    
    func isSelectedRate(_ rate: RateFilter) -> Bool {
        selectedRate == rate
        
    }
    
    func togleRateFilter(_ rate: RateFilter) {
        if selectedRate == rate {
            selectedRate = nil
        }else{
            selectedRate = rate
        }
    }
    
    func categorySelected(_ category: CategoryFilter) -> Bool {
        selectedCategory.contains(category)
    }
    
    func categoryToggeled(_ category: CategoryFilter) {
        if selectedCategory.contains(category){
            selectedCategory.remove(category)
        }else{
            selectedCategory.insert(category)
        }
    }
    
}


