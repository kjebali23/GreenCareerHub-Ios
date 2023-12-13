//
//  ResetPasswordResponse.swift
//  GestionUser
//
//  Created by ayouboueslati on 13/12/2023.
//

import Foundation

struct ResetPasswordResponse: Codable {
    let success: Bool
    let message: String
    // Add any other fields you expect in the response

    enum CodingKeys: String, CodingKey {
        case success
        case message
        // Add any other fields you expect in the response
    }
}
