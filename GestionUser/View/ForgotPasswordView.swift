import SwiftUI

struct ForgotPasswordView: View {
    @StateObject private var viewModel = ForgotPassViewModel()
    @StateObject private var coordinator = ForgotPasswordCoordinator()

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.customNavyBlue, Color.customBlue]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                VStack {
                    Image("logo (2)") // Replace with your actual logo name
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 120)
                        .padding(.bottom, 30)

                    VStack(spacing: 20) {
                        if !viewModel.shouldNavigateToOTPView {
                            Text("Forgot Password?")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(.bottom, 20)

                            TextField("Email", text: $viewModel.email)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.7)))
                                .padding(.bottom, 30)

                            Button(action: {
                                viewModel.sendResetPasswordLink()
                            }) {
                                Text("Send Reset Password Link")
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.black))
                            }
                        } else {
                            Text("Reset Password Link Sent!")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(.bottom, 20)

                            NavigationLink(
                                destination: OtpView(email: viewModel.email, coordinator: coordinator),
                                isActive: $viewModel.shouldNavigateToOTPView
                            )
 {
                                EmptyView()
                            }
                            .onChange(of: viewModel.shouldNavigateToOTPView) { value in
                                print("shouldNavigateToOTPView changed: \(value)")
                            }
                            .hidden()

                        }
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Forgot Password", displayMode: .inline)
            .environmentObject(coordinator)
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
