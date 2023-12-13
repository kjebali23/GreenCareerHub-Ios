enum ResetPasswordResult: Identifiable {
    case success
    case failure(Error)

    var id: String {
        switch self {
        case .success:
            return "success"
        case .failure(let error):
            return error.localizedDescription
        }
    }
}
