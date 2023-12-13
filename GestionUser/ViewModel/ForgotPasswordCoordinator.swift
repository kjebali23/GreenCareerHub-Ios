//
//  ForgotPasswordCoordinator.swift
//  GestionUser
//
//  Created by ayouboueslati on 6/12/2023.
//
import SwiftUI

class ForgotPasswordCoordinator: ObservableObject {
    @Published var isOTPPresented = false
    @Published var isResetPasswordPresented = false

    // Add a closure to set the email in OTPViewModel
    var setEmailInOTPViewModel: ((String) -> Void)?

    var email: String = "" {
        didSet {
            // Call the closure to set the email in OTPViewModel
            setEmailInOTPViewModel?(email)
        }
    }

    func navigateToOTPView() {
        isOTPPresented = true
    }

    func navigateToResetPasswordView() {
        isResetPasswordPresented = true
    }
}
