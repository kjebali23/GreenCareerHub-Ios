//
//  LoginViewModel.swift
//  GestionUser
//
//  Created by ayoub oueslati on 29/11/2023.
//

import Foundation

class LoginViewModel: ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    @Published var loginError: String?
    @Published var isLoggedIn = false
   
    private let authService = AuthService.shared
    

    func loginUser() {
            authService.login(email: email, password: password) { result in
                switch result {
                case .success(let user):
                
                    print("Login successful: \(user)")

                    self.isLoggedIn = true
                case .failure(let error):
                    
                    self.loginError = "Login failed: \(error)"
                }
            }
        }
    }
    

