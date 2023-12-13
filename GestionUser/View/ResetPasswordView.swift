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
                        viewModel.resetPassword(newPassword: newPassword, code: code)
                    }) {
                        Text("Reset Password")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.black))
                    }
                    .alert(item: $viewModel.resetPasswordResult) { result in
                        switch result {
                        case .success:
                            return Alert(title: Text("Success"), message: Text("Password reset successfully"), dismissButton: .default(Text("OK")))
                        case .failure(let error):
                            return Alert(title: Text("Error"), message: Text(error.localizedDescription), dismissButton: .default(Text("OK")))
                        }
                    }
                }
                .padding(.horizontal, 30)
            }
            .padding()
        }
        .navigationBarTitle("Reset Password", displayMode: .inline)
    }
}
