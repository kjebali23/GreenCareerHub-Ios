import SwiftUI
import Combine

// ViewModel
class ResetPasswordViewModel: ObservableObject {
    @Published var confirmPassword: String = ""
    @Published private(set) var isResetPasswordSuccess: Bool = false
    @Published var resetPasswordResult: Result<String, Error>? = nil

    private var cancellables: Set<AnyCancellable> = []

    func resetPassword(code: String, newPassword: String) {
        // Add your reset password logic here
        // For simplicity, I'm assuming success if the password and confirmation match
        if newPassword == confirmPassword {
            self.isResetPasswordSuccess = true
            self.resetPasswordResult = .success("Password reset successfully")
        } else {
            let error = NSError(domain: "YourDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Passwords do not match"])
            self.resetPasswordResult = .failure(error)
        }
    }

    // Add any other necessary methods or properties
}
