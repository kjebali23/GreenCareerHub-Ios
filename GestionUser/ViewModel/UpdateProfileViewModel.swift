// UpdateProfileViewModel.swift

import Foundation

class UpdateProfileViewModel: ObservableObject {
    func updateProfile(email: String, updatedData: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
        AuthService.shared.updateProfile(email: email, updatedData: updatedData) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
