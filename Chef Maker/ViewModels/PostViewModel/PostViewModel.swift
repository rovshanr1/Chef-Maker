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

    
    private let db = Firestore.firestore()
    private let collectionName = "posts"
    let appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
    }

    
    func uploadPost(image: UIImage, form: PostFormData) async throws {
        let token = try await appState.getIdToken()
        let uploadResult = try await ImageKitService.uploadImageToBackend(image: image, fileName: UUID().uuidString, token: token)

        let post = await PostModel(
            id: UUID().uuidString,
            title: form.title,
            description: form.description,
            postImage: uploadResult.url,
            ingredients: form.ingredients,
            cookingTime: form.cookingTime,
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

        
        try await createPost(post)
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

