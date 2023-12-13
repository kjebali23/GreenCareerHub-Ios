import SwiftUI

struct UserProfileView: View {
    @ObservedObject var viewModel: UserProfileViewModel
    let userId: String
    let accessToken: String

    init(userId: String, accessToken: String) {
        self.userId = userId
        self.accessToken = accessToken
        self.viewModel = UserProfileViewModel()
    }

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let user = viewModel.user {
                // Customize the view based on your UI requirements
                Text("User ID: \(user.id ?? "")")
                Text("Email: \(user.email ?? "")")
                Text("Phone Number: \(user.phoneNumber ?? "")")
                Text("CV: \(user.cv ?? "")")
                Text("Birth Date: \(user.birthDate ?? "")")
            } else if let error = viewModel.error {
                Text("Error: \(error.localizedDescription)")
            } else {
                Text("User not found")
            }
        }
        .onAppear {
            viewModel.getUserProfileById(userId: userId, accessToken: accessToken)
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(userId: "your_user_id", accessToken: "your_access_token")
    }
}
