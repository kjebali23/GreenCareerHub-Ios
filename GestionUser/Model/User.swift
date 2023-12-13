//
//  User.swift
//  GestionUser
//
//  Created by ayouboueslati on 28/11/2023.
//

import Foundation

struct User: Codable {
    var id: String
    var email: String
    var password: String
    var username: String
    var cv: String?
    var birthdate: String?
    var phoneNumber: String?
}
