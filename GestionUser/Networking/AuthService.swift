//
//  AuthService.swift
//  GestionUser
//
//  Created by ayoub oueslati on 29/11/2023.
//

import Foundation



class AuthService{
    static let shared = AuthService()
      private let baseURL = "http://192.168.202.238:3000/auth"

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
                   let user = try JSONDecoder().decode(User.self, from: data)
                   completion(.success(user))
               } catch {
                   completion(.failure(error))
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

            // Print the response as a string for debugging
            if let responseString = String(data: data ?? Data(), encoding: .utf8) {
                print("Response String: \(responseString)")
            }

            do {
                let response = try JSONDecoder().decode([String: String].self, from: data!)
                if let message = response["message"], message.lowercased() == "reset token sent successfully" {
                    completion(.success(message))
                } else {
                    completion(.failure(NSError(domain: "InvalidResponse", code: 0, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
       func resetPassword(token: String, newPassword: String, completion: @escaping (Result<String, Error>) -> Void) {
           let resetPasswordURL = URL(string: "\(baseURL)/reset-password/\(token)")!

           var request = URLRequest(url: resetPasswordURL)
           request.httpMethod = "POST"
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")

           let requestBody: [String: Any] = [
               "password": newPassword
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

               // Handle response and errors as needed
               // You may want to decode the response to check for success or failure

               completion(.success("Password reset successfully"))
           }.resume()
       }


}
