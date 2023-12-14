//  NetworkingService.swift
//  gestion_entreprise
//
//  Created by khalil on 2/12/2023.
//

import Foundation

class NetworkingService {
    static let shared = NetworkingService()
    
    func fetchData(completion: @escaping ([Opportunity]?) -> Void) {
        guard let url = URL(string: "http://192.168.135.238:8000/todo/todos") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let opportunities = try JSONDecoder().decode([Opportunity].self, from: data)
                completion(opportunities)
            } catch {
                print(error)
                completion(nil)
            }
        }.resume()
    }
    
    func addData(opportunity: Opportunity, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let url = URL(string: "http://192.168.135.238:8000/todo/todo") else {
            completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonData = try JSONEncoder().encode(opportunity)
            request.httpBody = jsonData
        } catch {
            print(error)
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            completion(.success(true))
        }.resume()
    }
    
    
    
   /* private func sendDataToServer() {
        guard let url = URL(string: "http://localhost:8000/postule/postule") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let todoData: [String: Any] = [
            "nom": nom,
            "prenom": prenom
            // You might need to add more fields like "cv" based on your server expectations
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: todoData)
        } catch let error {
            print("Error encoding todo data: \(error.localizedDescription)")
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle the response from the server
            // You may want to check for errors and handle success accordingly
            if let data = data {
                print(String(data: data, encoding: .utf8) ?? "")
            }
        }.resume()
    }*/

}
