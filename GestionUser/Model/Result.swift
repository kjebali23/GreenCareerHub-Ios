//
//  Result.swift
//  GestionUser
//
//  Created by ayouboueslati on 6/12/2023.
//

import Foundation

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
    
    var isSuccess: Bool {
        if case .success = self {
            return true
        }
        return false
    }
    
    var value: T? {
        if case .success(let value) = self {
            return value
        }
        return nil
    }
    
    var error: E? {
        if case .failure(let error) = self {
            return error
        }
        return nil
    }
}
