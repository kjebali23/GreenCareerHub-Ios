import Foundation
import SwiftUI
import Combine

class ForgotPassViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var code: String = ""
    @Published var isResetPasswordLinkSent: Bool = false {
            didSet {
                objectWillChange.send()
            }
        }
    @Published private(set) var isResetPasswordSuccess: Bool = false
    @Published var newPassword: String = ""
    @Published var resetPasswordResult: Result<String, Error>? = nil

    private var cancellables: Set<AnyCancellable> = []

    private var _resetPasswordAlertItem: AlertItem?
    var resetPasswordAlertItem: AlertItem? {
        get { _resetPasswordAlertItem }
        set {
            _resetPasswordAlertItem = newValue
            objectWillChange.send()
        }
    }

    func sendResetPasswordLink() {
        print("Sending reset password link for email: \(email)")

        AuthService.shared.forgotPassword(email: email) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let message):
                    self.resetPasswordResult = .success(message)
                    self.resetPasswordAlertItem = AlertItem.success(message: message)
                    self.isResetPasswordLinkSent = true // Set it to true when the link is sent

                    // Additional code to navigate to the ResetPasswordView if needed
                    // For example, you can trigger the NavigationLink programmatically
                    // based on the value of isResetPasswordLinkSent.
                case .failure(let error):
                    self.resetPasswordResult = .failure(error)
                    self.resetPasswordAlertItem = AlertItem.failure(error: error)
                }
            }
        }
    }

    func resetPassword(newPassword: String, code: String) {
        print("Resetting password with code: \(code)")

        // Call your reset password logic here
        // Example logic:
        if code == "123456" {
            self.isResetPasswordSuccess = true
            self.resetPasswordResult = .success("Password reset successfully")
        } else {
            let error = NSError(domain: "YourDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid code"])
            self.resetPasswordResult = .failure(error)
        }
    }
}

struct AlertItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String?

    static func success(message: String) -> AlertItem {
        AlertItem(title: "Success", message: message)
    }

    static func failure(error: Error) -> AlertItem {
        AlertItem(title: "Error", message: error.localizedDescription)
    }
}
