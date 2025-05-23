//
//
//  Chef Maker
//
//  Created by Rovshan Rasulov on 06.04.25.
//

import Foundation

@MainActor
protocol DiscoveryViewModelProtocol: BaseViewModelProtocol {
    var selectedCategories: Set<Category> { get set }
    var searchText: String { get set }
    var filteredCategories: [Category] { get }
    
    func toggleCategory(_ category: Category)
    func clearSelectedCategories()
    func isSelected(_ category: Category) -> Bool
}

@MainActor
class DiscoveryViewViewModel: BaseViewModel<Recipe>, DiscoveryViewModelProtocol {
    @Published var selectedCategories: Set<Category> = []
    @Published var searchText: String = ""
    @Published var userRecipes: [PostModel] = []
    @Published var userProfiles: [String: ProfileModel] = [:]
    @Published var isLoadingMore = false
    
    
    
    private var allCategories: [Category] = Category.allCases.sorted { $0.rawValue < $1.rawValue }
    private let profileService: ProfileServiceProtocol
    private var lastPostId: String?
    
    init(profileService: ProfileServiceProtocol = ProfileService()){
        self.profileService = profileService
        super.init()
    }
    
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
    
    
    
    func fetchUserRecipes() async {
         do {
             let posts = try await profileService.fetchAllPosts(limit: 10, lastPostId: lastPostId)
             userRecipes = posts
             lastPostId = posts.last?.id
         } catch {
             self.error = error as? NetworkError ?? .networkError(error)
         }
     }
    
    func loadMorePosts() async {
        guard !isLoadingMore, let lastPostId = lastPostId else { return }
        isLoadingMore = true
        
        do {
            let newPosts = try await profileService.fetchAllPosts(limit: 10, lastPostId: lastPostId)
            userRecipes.append(contentsOf: newPosts)
            self.lastPostId = newPosts.last?.id
        } catch {
            self.error = error as? NetworkError ?? .networkError(error)
        }
        
        isLoadingMore = false
    }
    
    func getProfile(for userId: String) -> ProfileModel {
         if let cachedProfile = userProfiles[userId] {
             return cachedProfile
         }
         
         Task {
             do {
                 let profile = try await profileService.fetchProfile(for: userId)
                 userProfiles[userId] = profile
             } catch {
                 print("Error fetching profile: \(error)")
             }
         }
         
        return ProfileModel.preview
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


