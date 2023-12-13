//
//  RegisterViewModel.swift
//  GestionUser
//
//  Created by ayouboueslati on 28/11/2023.
//

import Foundation

class RegisterViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var registrationError: String?
    @Published var isRegistrationInProgress = false
    
    var isRegistrationValid: Bool {
        return isEmailValid && isPasswordValid
    }
    
    private var isEmailValid: Bool {
        return !email.isEmpty && email.isValidEmail()
    }
    
    private var isPasswordValid: Bool {
        return !password.isEmpty && password.count >= 6
    }
    
    func registerUser(completion: @escaping (Result<User, Error>) -> Void) {
        guard !isRegistrationInProgress, isRegistrationValid else {
            registrationError = "Invalid registration information"
            return
        }
        
        isRegistrationInProgress = true
        
        AuthService.shared.registerUser(email: email, password: password) { result in
            // Reset the flag regardless of success or failure
            defer { self.isRegistrationInProgress = false }
            
            switch result {
            case .success(let user):
                print("Registration successful: \(user)")
                // Optionally, you can perform any additional actions after successful registration
                completion(.success(user))
                
            case .failure(let error):
                self.registrationError = "Registration failed: \(error)"
                completion(.failure(error))
            }
        }
    }
}

extension String {
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
}
