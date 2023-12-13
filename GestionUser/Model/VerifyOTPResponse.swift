//
//  VerifyOTPResponse.swift
//  GestionUser
//
//  Created by ayouboueslati on 6/12/2023.
//

import Foundation

struct VerifyOTPResponse: Decodable {
    let success: Bool
    let message: String
}
