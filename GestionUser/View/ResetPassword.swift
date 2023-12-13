// ResetPasswordView.swift

import SwiftUI

struct ResetPasswordView: View {
    @ObservedObject var viewModel: ForgotPassViewModel
    @Binding var code: String
    @Binding var newPassword: String

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.customNavyBlue, Color.customBlue]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack {
                Image("logo (2)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 120)
                    .padding(.bottom, 30)

                VStack(spacing: 20) {
                    Text("Reset Password")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.bottom, 20)

                    SecureField("Code", text: $code)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.7)))
                        .padding(.bottom, 10)

                    SecureField("New Password", text: $newPassword)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.7)))
                        .padding(.bottom, 30)

                    Button(action: {
                        viewModel.sendResetPasswordLink()
                        print("isResetPasswordLinkSent: \(viewModel.isResetPasswordLinkSent)")
                    }) {
                        Text("Send Reset Password Link")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.black))
                    }

                    .alert(item: $viewModel.resetPasswordAlertItem) { alertItem in
                        Alert(title: Text(alertItem.title), message: alertItem.message.map(Text.init))
                    }
                }
                .padding(.horizontal, 30)
            }
            .padding()
        }
        .navigationBarTitle("Reset Password", displayMode: .inline)
    }
}

