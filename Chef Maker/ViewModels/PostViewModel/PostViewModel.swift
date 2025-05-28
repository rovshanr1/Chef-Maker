//
//  PostViewModel.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 07.05.25.
//

import Foundation
import FirebaseFirestore

protocol PostServiceProtocol{
    func uploadPost(image: UIImage, form: PostFormData) async throws
    func fetchAllPosts() async throws -> [PostModel]
    func fetchPosts(by id: String) async throws -> PostModel?
    func deletePost(by id: String) async throws
}


final class PostViewModel: ObservableObject, PostServiceProtocol {
    // MARK: - Published Properties
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var ingredients: [SelectedIngredient] = []
    @Published var category: String = ""
    @Published var difficulty: String = ""
    @Published var nutrients: String = ""
    @Published var selectedHour: Int = 0
    @Published var selectedMinute: Int = 0
    @Published var serving: Int = 1
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    
    
    private let db = Firestore.firestore()
    private let collectionName = "posts"
    let appState: AppState
    let selectedImage: UIImage
    
    init(appState: AppState, selectedImage: UIImage) {
        self.appState = appState
        self.selectedImage = selectedImage
    }
    
    func checkFormValidity() -> Bool {
        guard !title.isEmpty, !description.isEmpty else {
            errorMessage = "All Text Fields Are Required!"
            return false
        }
        return true
        
    }
    
    @MainActor
    func uploadPost(image: UIImage, form: PostFormData) async throws {
        let token = try await appState.getIdToken()
        let uploadResult = try await ImageKitService.uploadImageToBackend(image: image, fileName: UUID().uuidString, token: token)
        
        let post = PostModel(
            id: UUID().uuidString,
            title: form.title,
            description: form.description,
            postImage: uploadResult.url,
            ingredients: ingredients,
            cookingTime: form.cookingTime,
            serving: form.serving,
            category: form.category,
            difficulty: form.difficulty,
            nutrients: form.nutrients,
            authorId: appState.currentProfile?.id ?? "unknown",
            createdAt: Date(),
            likes: 0,
            comments: 0,
            saves: 0,
            isLiked: false,
            isSaved: false
        )
        
        let batch = db.batch()
        
        let postRef = db.collection(collectionName).document(post.id)
        batch.setData(post.toFirebase(), forDocument: postRef)
        
        if let userId =  appState.currentProfile?.id {
            let userRef = db.collection("users").document(userId)
            batch.updateData(["postCount": FieldValue.increment(Int64(1))], forDocument: userRef)
        }
        
        try await batch.commit()
        
        if var currentProfile = appState.currentProfile {
            currentProfile.postCount += 1
            
            appState.currentProfile = currentProfile
            
        }
    }
    
    func addIngredient(name: String, quantity: String, unit: String){
        let newIngredient = SelectedIngredient(
            id: UUID().uuidString,
            name: name,
            quantity: quantity,
            unit: unit
        )
        
        ingredients.append(newIngredient)
    }
    
    func loadExampleIngredients() -> [FilterIngredientsModel]{
        guard let url = Bundle.main.url(forResource: "local_ingredients", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let ingredients = try? JSONDecoder().decode([FilterIngredientsModel].self, from: data)
        else { return [] }
        
        return ingredients
    }
    
    func removeIngredient(at index: Int){
        ingredients.remove(at: index)
    }
    
    @MainActor
    func handlePost() async -> Bool {
        guard !ingredients.isEmpty else {
            errorMessage = "Please add at least one ingredient"
            return false
        }
        
        guard selectedMinute > 0 else {
            errorMessage = "Please select a valid cooking time"
            return false
        }
        
        isLoading = true
        defer { isLoading = false }
        
        let form = PostFormData(
            title: title,
            description: description,
            ingredients: ingredients,
            cookingTime: "\(selectedHour)h \(selectedMinute)m",
            serving: "\(serving) servings",
            category: category,
            difficulty: difficulty,
            nutrients: nutrients
        )
        
        do {
            try await uploadPost(image: selectedImage, form: form)
            return true
            
        } catch {
            await MainActor.run {
                errorMessage = error.localizedDescription
            }
            return false
        }
    }
    
    
    private func createPost(_ post: PostModel) async throws {
        let data = post.toFirebase()
        try await db.collection(collectionName).document(post.id).setData(data, merge: true)
    }
    
    func fetchAllPosts() async throws -> [PostModel] {
        let snapshot = try await db.collection(collectionName).getDocuments()
        return snapshot.documents.compactMap { document in
            guard let post = PostModel.fromFirebase(document.data()) else { return nil }
            return post
        }
        
    }
    
    func fetchPosts(by id: String) async throws -> PostModel? {
        let document = try await db.collection(collectionName).document(id).getDocument()
        guard document.exists, let data = document.data(), let post = PostModel.fromFirebase(data) else {
            return nil
        }
        return post
    }
    
    func deletePost(by id: String) async throws {
        try await db.collection(collectionName).document(id).delete()
    }
}

