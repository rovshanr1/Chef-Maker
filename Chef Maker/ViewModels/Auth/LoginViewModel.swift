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
    @Published var isLoggedIn: Bool = false
    
    //Service
    private let authService: AuthServiceProtocol
    
    init(authService: AuthServiceProtocol = AuthService.shared){
        self.authService = authService
    }
    
    func login() {
       //TextFields cannot be empty
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields."
            return
        }
        
        //check valid email adress
        guard email.contains("@") else {
            errorMessage = "Please enter a valid email adress."
            return
        }
        
        
        Task{
            isLoading = true
            errorMessage = nil
            isLoggedIn = false
            
            do{
                try await authService.login(email: email, password: password)
                isLoggedIn = true
            } catch {
                if let authError = error as? AuthError {
                    errorMessage = authError.localizedDescription
                } else {
                    errorMessage = mapFirebaseError(error).localizedDescription
                }
            }
            isLoading = false
        }
    }
} 
