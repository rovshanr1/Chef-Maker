//
//  BaseViewModel.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 07.04.25.
//

import Foundation

@MainActor
protocol BaseViewModelProtocol: ObservableObject {
    associatedtype DataType
    var isLoading: Bool { get set }
    var error: NetworkError? { get set }
    var data: [DataType] { get set }
}

@MainActor
class BaseViewModel<T>: BaseViewModelProtocol {
    @Published var isLoading: Bool = false
    @Published var error: NetworkError?
    @Published var profileError: ProfileError?
    @Published var data: [T] = []
    
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = BaseNetworkService()) {
        self.networkService = networkService
        validateAPIKey()
    }
    
    private func validateAPIKey() {
        if Bundle.main.infoDictionary?["API_KEY"] as? String == nil {
            error = .missingAPIKey
        }
    }
    
    var apiKey: String {
        if let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String {
            return apiKey
        }
        return ""
    }
}
