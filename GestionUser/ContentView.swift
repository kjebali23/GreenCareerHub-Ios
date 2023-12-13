import SwiftUI

struct ContentView: View {
    @State private var isForgotPasswordActive = false
    @State private var isResetPasswordActive = false // Add this state

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: LoginView()) {
                    Text("Login")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                }
                .padding()
                
                NavigationLink(destination: ForgotPasswordView()) {
                    Text("Forgot Password")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                }
                .padding()
                
                NavigationLink(destination: RegisterView()) {
                    Text("Register")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                }
                .padding()
                
                NavigationLink(destination: ResetPasswordView(viewModel: ForgotPassViewModel(), code: .constant(""), newPassword: .constant("")),
                               isActive: $isResetPasswordActive
                ) {
                    Text("Reset Password Manually")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                }
                .padding()

                NavigationLink(destination: UserProfileView()) {
                    Text("User Profile")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                }
                .padding()

                NavigationLink(destination: ForgotPasswordView(),
                               isActive: $isForgotPasswordActive
                ){
                    EmptyView()
                }
                .hidden()
            }
            .navigationBarTitle("App Navigation", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
