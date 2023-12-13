//
//  UserProfileError.swift
//  GestionUser
//
//  Created by ayouboueslati on 12/12/2023.
//

import Foundation

enum UserProfileError: Error {
    case invalidData
    case networkError(Error)
    case decodingError(Error)
    case encodingError(Error)  // Add this case for encoding errors
}
