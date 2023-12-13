import Foundation
import SwiftUI
import Combine

class ForgotPassViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var code: String = ""
    var coordinator: ForgotPasswordCoordinator?
    @Published var shouldNavigateToOTPView: Bool = false // Renamed property
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
                    self.shouldNavigateToOTPView = true // Set this to true after OTP is sent
                    print("shouldNavigateToOTPView set to true")
                case .failure(let error):
                    self.resetPasswordResult = .failure(error)
                    self.resetPasswordAlertItem = AlertItem.failure(error: error)
                    print("Error sending reset password link: \(error.localizedDescription)")
                }
            }
        }
    }


    func navigateToOTPView() {
        coordinator?.navigateToOTPView()
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
