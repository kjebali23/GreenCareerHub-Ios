import SwiftUI
struct ResetPasswordView: View {
    @ObservedObject var viewModel: ResetPasswordViewModel
    @Binding var code: String
    @Binding var newPassword: String

    var body: some View {
        VStack {
            Text("Enter OTP Code and New Password")
                .font(.title)
                .padding()

            TextField("OTP Code", text: $code)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.7)))
                .padding(.bottom, 20)

            SecureField("New Password", text: $newPassword)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.7)))
                .padding(.bottom, 20)

            SecureField("Confirm Password", text: $viewModel.confirmPassword)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.7)))
                .padding(.bottom, 20)

            Button(action: {
                viewModel.resetPassword(code: code, newPassword: newPassword)
            }) {
                Text("Reset Password")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.black))
            }
            .padding(.horizontal, 30)

            if let result = viewModel.resetPasswordResult {
                switch result {
                case .success(let message):
                    Text(message)
                        .foregroundColor(.green)
                        .padding()
                case .failure(let error):
                    Text(error.localizedDescription)
                        .foregroundColor(.red)
                        .padding()
                }
            }
        }
        .padding()
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView(viewModel: ResetPasswordViewModel(), code: .constant("123456"), newPassword: .constant(""))
    }
}



