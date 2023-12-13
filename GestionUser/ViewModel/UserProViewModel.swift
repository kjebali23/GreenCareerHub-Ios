    import Foundation
    import Combine

    class UserProViewModel: ObservableObject {
        private var cancellables = Set<AnyCancellable>()

        @Published var userProfile: User?
        @Published var isLoading = false
        @Published var error: Error?

        func fetchUserProfile(userId: String, accessToken: String) {
            isLoading = true

            AuthService.shared.getUserProfileById(userId: userId, accessToken: accessToken)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .finished:
                        self?.isLoading = false
                    case .failure(let error):
                        self?.error = error
                        self?.isLoading = false
                    }
                }, receiveValue: { [weak self] userProfile in
                    self?.userProfile = userProfile
                })
                .store(in: &cancellables)
        }
    }
