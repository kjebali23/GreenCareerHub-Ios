//
//  AuthResponse.swift
//  GestionUser
//
//  Created by ayoub oueslati on 29/11/2023.
//

import Foundation

struct AuthResponse: Codable {
    let message: String
    let user: User?
}
