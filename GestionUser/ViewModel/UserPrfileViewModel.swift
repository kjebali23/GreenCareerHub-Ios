import Foundation
import Combine

class UserProfileViewModel: ObservableObject {
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()

    @Published var user: User?
    @Published var isLoading = false
    @Published var error: Error?

    func getUserProfileById(userId: String, accessToken: String) {
        isLoading = true

        AuthService.shared.getUserProfileById(userId: userId, accessToken: accessToken) { [weak self] result in
            switch result {
            case .success(let userProfile):
                // Successfully retrieved user profile
                self?.user = userProfile
                self?.isLoading = false
            case .failure(let error):
                // Handle specific error cases if needed
                self?.error = error
                self?.isLoading = false
            }
        }
    }

    deinit {
        cancellables.forEach { $0.cancel() }
    }
}
