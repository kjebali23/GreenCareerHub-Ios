import Foundation

struct User: Codable {
    var id: String?
    var email: String?
    var password: String?
    var phoneNumber: String? // Add this property
    var cv: String? // Add this property
    var birthDate: String? // Add this property

    enum CodingKeys: String, CodingKey {
        case id
        case email
        case password
        case phoneNumber
        case cv
        case birthDate = "birthdate"
    }
}
