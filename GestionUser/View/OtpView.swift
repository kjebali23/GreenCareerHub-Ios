import SwiftUI

struct OtpView: View {
    @ObservedObject private var viewModel: OtpViewModel
    @ObservedObject private var coordinator: ForgotPasswordCoordinator

    // Update the initializer to pass the email dynamically
    init(email: String, coordinator: ForgotPasswordCoordinator) {
         self._viewModel = ObservedObject(wrappedValue: OtpViewModel(email: email))
         self.coordinator = coordinator
     }


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

                    Text("Enter OTP")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()

                    TextField("OTP", text: $viewModel.otp)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.7)))
                        .padding(.bottom, 30)

                    Button(action: {
                        viewModel.verifyOTP { result in
                            switch result {
                            case .success(let message):
                                print(message)
                                viewModel.resetPassword(newPassword: "newPassword")
                            case .failure(let error):
                                print("Error verifying OTP: \(error.localizedDescription)")
                            }
                        }
                    }) {
                        Text("Verify OTP")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.black))
                    }
                    .padding(.horizontal, 30)
                    .onAppear {
                        print("Verify OTP button appeared")
                    }

                    Button(action: {
                        viewModel.resetPassword(newPassword: "newPassword")
                    }) {
                        Text("Reset Password")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.black))
                    }
                    .padding(.horizontal, 30)
                }
                .padding()
            }
            .navigationBarTitle("OTP Verification", displayMode: .inline)
            .environmentObject(coordinator)
        }
    }
}


struct OtpView_Previews: PreviewProvider {
    static var previews: some View {
        OtpView(email: "user@example.com", coordinator: ForgotPasswordCoordinator())
    }
}
