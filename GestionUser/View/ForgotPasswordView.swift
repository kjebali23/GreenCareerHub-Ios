import SwiftUI

struct ForgotPasswordView: View {
    @StateObject private var viewModel = ForgotPassViewModel()

    var body: some View {
        NavigationView {
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
                        if !viewModel.isResetPasswordLinkSent {
                            Text("Forgot Password?")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(.bottom, 20)

                            TextField("Email", text: $viewModel.email)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.7)))
                                .padding(.bottom, 30)

                        } else {
                            Text("Reset Password Link Sent!")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(.bottom, 20)

                            NavigationLink(
                                destination: ResetPasswordView(viewModel: viewModel, code: $viewModel.code, newPassword: $viewModel.newPassword),
                                isActive: $viewModel.isResetPasswordLinkSent
                            ) {
                                EmptyView()
                            }
                            .hidden()

                        }

                        Button(action: {
                            viewModel.sendResetPasswordLink()
                        }) {
                            Text("Send Reset Password Link")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.black))
                        }
                    }
                    .padding(.horizontal, 30)
                }
                .padding()
            }
            .navigationBarTitle("Forgot Password", displayMode: .inline)
        }
    }
}
struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
