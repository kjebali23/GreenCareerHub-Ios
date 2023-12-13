import Foundation
import SwiftUI

class OtpViewModel: ObservableObject {
    @Published var otp: String = ""
    @Published var email: String = ""

    init(email: String) {
            self.email = email
        }
    
    func verifyOTP(completion: @escaping (Result<String, Error>) -> Void) {
        AuthService.shared.verifyOTP(email: email, otp: otp) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }

    func resetPassword(newPassword: String) {
        AuthService.shared.resetPassword(email: email, otp: otp, password: newPassword) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let message):
                    // Password reset successfully, handle the success message
                    print(message)
                case .failure(let error):
                    // Handle the failure case
                    print("Error resetting password: \(error.localizedDescription)")
                }
            }
        }
    }
}
