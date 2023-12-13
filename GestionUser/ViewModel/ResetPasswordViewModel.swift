// ResetPasswordViewModel.swift

import Foundation
import SwiftUI
import Combine

class ResetPasswordViewModel: ObservableObject {
    @Published var resetPasswordResult: Result<String, Error>? = nil

    private var cancellables: Set<AnyCancellable> = []

    func resetPassword(email: String, code: String, newPassword: String) {
        // Add your logic to reset the password here
        // Call the appropriate API or perform necessary actions

        // For now, let's simulate both success and failure scenarios
        if code == "correct_token" {
            // Simulate a successful reset with a message
            self.resetPasswordResult = .success("Password reset successfully for email: \(email)")
        } else {
            // Simulate a failure with a custom error
            let error = NSError(domain: "YourDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid code"])
            self.resetPasswordResult = .failure(error)
        }
    }
}

// Make Result conform to Identifiable
extension Result: Identifiable where Success == String, Failure == Error {
    public var id: String {
        switch self {
        case .success(let message):
            return message
        case .failure(let error):
            return error.localizedDescription
        }
    }
}
