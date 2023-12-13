//
//  AuthService.swift
//  GestionUser
//
//  Created by ayoub oueslati on 29/11/2023.
//

import Foundation
import Combine




class AuthService{
    
        static let shared = AuthService()
        private let baseURL = "http://192.168.57.238:3000/auth"
        var currentUser: User?

      func registerUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
          print("Making register request")

          let registerURLString = "\(baseURL)/register"

          guard let registerURL = URL(string: registerURLString) else {
              completion(.failure(NSError(domain: "InvalidURL", code: 0, userInfo: nil)))
              return
          }

          var request = URLRequest(url: registerURL)
          request.httpMethod = "POST"
          request.addValue("application/json", forHTTPHeaderField: "Content-Type")

          let requestBody: [String: Any] = [
              "email": email,
              "password": password
          ]

          do {
              let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
              request.httpBody = jsonData
          } catch {
              completion(.failure(error))
              return
          }

          URLSession.shared.dataTask(with: request) { (data, response, error) in
              if let error = error {
                  print("Error in data task:", error)
                  completion(.failure(error))
                  return
              }

              guard let data = data else {
                  print("No data received")
                  completion(.failure(NSError(domain: "InvalidData", code: 0, userInfo: nil)))
                  return
              }

              do {
                  let user = try JSONDecoder().decode(User.self, from: data)
                  completion(.success(user))
              } catch {
                  completion(.failure(error))
              }
          }.resume()
      }
    
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        let loginURL = URL(string: "\(baseURL)/login")!

        var request = URLRequest(url: loginURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody: [String: Any] = [
            "email": email,
            "password": password
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self = self else { return } // Ensure self is not nil

            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "InvalidData", code: 0, userInfo: nil)))
                return
            }

            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                self.currentUser = user

                // Save user data to UserDefaults
                self.saveUserToUserDefaults(user)

                completion(.success(user))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    private func saveUserToUserDefaults(_ user: User) {
        let userDefaults = UserDefaults.standard

        userDefaults.set(user.id, forKey: "UserId")
         userDefaults.set(user.email, forKey: "UserEmail")
         userDefaults.set(user.phoneNumber, forKey: "UserPhoneNumber")
         userDefaults.set(user.cv, forKey: "UserCV")
         userDefaults.set(user.birthDate, forKey: "UserBirthDate")
        print("User saved to UserDefaults: \(user)")

        userDefaults.synchronize()
        print("User saved to UserDefaults: \(user)")

    }

    

    
    func logout(refreshToken: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let logoutURL = URL(string: "\(baseURL)/logout")!

           var request = URLRequest(url: logoutURL)
           request.httpMethod = "POST"
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")

           let requestBody: [String: Any] = [
               "refreshToken": refreshToken
           ]

           do {
               let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
               request.httpBody = jsonData
           } catch {
               completion(.failure(error))
               return
           }

           URLSession.shared.dataTask(with: request) { (_, _, error) in
               if let error = error {
                   completion(.failure(error))
               } else {
                   // Successful logout
                   completion(.success(()))
               }
           }.resume()
       }
    func forgotPassword(email: String, completion: @escaping (Result<String, Error>) -> Void) {
        let forgotPasswordURL = URL(string: "\(baseURL)/forgot-password")!

        var request = URLRequest(url: forgotPasswordURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody: [String: Any] = [
            "email": email
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            // Handle decoding errors, and check if 'user' field is missing
            do {
                let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data!)
                let message = authResponse.message
                completion(.success(message))
            } catch {
                // Handle decoding errors, and check if 'user' field is missing
                if let decodingError = error as? DecodingError, case .keyNotFound(_, _) = decodingError {
                    // 'user' field is missing, handle accordingly
                    print("User field is missing")
                } else {
                    // Other decoding errors
                    completion(.failure(error))
                }
            }
        }.resume()
    }



    func resetPassword(email: String, otp: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        let resetPasswordURL = URL(string: "\(baseURL)/reset-password")!

        var request = URLRequest(url: resetPasswordURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody: [String: Any] = [
            "email": email,
            "otp": otp,
            "password": password
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "InvalidData", code: 0, userInfo: nil)))
                return
            }

            do {
                let responseObject = try JSONDecoder().decode(ResetPasswordResponse.self, from: data)
                // Access the success field or any other necessary field
                if responseObject.success {
                    completion(.success(responseObject.message))
                } else {
                    completion(.failure(NSError(domain: "InvalidResponse", code: 0, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }



    func verifyOTP(email: String, otp: String, completion: @escaping (Result<String, Error>) -> Void) {
        let verifyOTPURL = URL(string: "\(baseURL)/verify-otp")!

        var request = URLRequest(url: verifyOTPURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody: [String: Any] = [
            "email": email,
            "otp": otp
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "InvalidData", code: 0, userInfo: nil)))
                return
            }

            do {
                let responseObject = try JSONDecoder().decode(VerifyOTPResponse.self, from: data)
                // Access the success field or any other necessary field
                if responseObject.success {
                    completion(.success(responseObject.message))
                } else {
                    completion(.failure(NSError(domain: "InvalidResponse", code: 0, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
   /* func getUserProfile(accessToken: String, completion: @escaping (Result<User, Error>) -> Void) {
        let userProfileURL = URL(string: "\(baseURL)/user-profile")!
        var request = URLRequest(url: userProfileURL)
        request.httpMethod = "GET"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "InvalidData", code: 0, userInfo: nil)))
                return
            }

            do {
                let responseObject = try JSONDecoder().decode(User.self, from: data)
                completion(.success(responseObject))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }*/

    
    func decodeJWT(token: String) throws -> [String: Any] {
        let jwtComponents = token.components(separatedBy: ".")
        guard jwtComponents.count > 1, let payloadData = Data(base64Encoded: jwtComponents[1]) else {
            throw NSError(domain: "InvalidToken", code: 0, userInfo: nil)
        }

        return try JSONSerialization.jsonObject(with: payloadData, options: []) as? [String: Any] ?? [:]
    }
    
    func updateProfile(email: String, updatedData: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
        let updateProfileURL = URL(string: "\(baseURL)/update-profile")!

        var request = URLRequest(url: updateProfileURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        var requestBody: [String: Any] = ["email": email]

        // Add updated data to the request body
        for (key, value) in updatedData {
            requestBody[key] = value
        }

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                // Successful profile update
                completion(.success(()))
            }
        }.resume()
    }
    
    func getUserProfileById(userId: String, accessToken: String, completion: @escaping (Result<User, Error>) -> Void) {
        let userProfileURL = URL(string: "\(baseURL)/user/\(userId)")!
        var request = URLRequest(url: userProfileURL)
        request.httpMethod = "GET"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "InvalidData", code: 0, userInfo: nil)))
                return
            }

            do {
                let responseObject = try JSONDecoder().decode(User.self, from: data)
                completion(.success(responseObject))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }



}
