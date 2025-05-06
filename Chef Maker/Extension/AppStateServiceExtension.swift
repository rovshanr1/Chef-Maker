//
//  AuthServiceExtension.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 05.05.25.
//

import Foundation

extension AppState{
    func getIdToken() async throws -> String {
        guard let user = auth.currentUser else {
            throw AuthError.unknown("Current user not found")
        }
        return try await withCheckedThrowingContinuation { continuation in
            user.getIDToken { token, error in
                if let token = token {
                    continuation.resume(returning: token)
                } else {
                    continuation.resume(throwing: error ?? AuthError.unknown("Token alınamadı"))
                }
            }
        }
    }
}
