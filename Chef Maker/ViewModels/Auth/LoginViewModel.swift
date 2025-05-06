import Foundation
import FirebaseAuth



@MainActor
class LoginViewModel: ObservableObject {
    //Input
    @Published var email: String = ""
    @Published var password: String = ""
    
    
    //UI-State
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    
    //Service
    let authService: AuthServiceProtocol
    let appState: AppState
    
    init(authService: AuthServiceProtocol = AuthService(), appState: AppState ) {
        self.authService = authService
        self.appState = appState
    }
    
    func login() async -> Bool {
        //TextFields cannot be empty
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields."
            return false
        }
        
        //check valid email adress
        guard email.contains("@") else {
            errorMessage = "Please enter a valid email adress."
            return false
        }
        
        isLoading = true
        errorMessage = nil
        defer { isLoading = false}
        do{
            try await authService.login(email: email, password: password)
            appState.isLoggedIn = true
            return true
        } catch {
            if let authError = error as? AuthError {
                errorMessage = authError.localizedDescription
            } else {
                errorMessage = mapFirebaseError(error).localizedDescription
            }
            return false
        }
    }
} 
