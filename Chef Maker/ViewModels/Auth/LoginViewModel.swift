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
    @Published var isLogedIn: Bool = false
    
    //Service
    private let authService: AuthServiceProtocol
    
    init(authService: AuthServiceProtocol = AuthService.shared){
        self.authService = authService
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
            defer { isLogedIn = false}
            
            do{
                try await authService.login(email: email, password: password)
                isLogedIn = true
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
