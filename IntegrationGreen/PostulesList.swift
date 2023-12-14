import SwiftUI

struct PostulesListView: View {
    var oppId: String

    @State private var postules: [Postule] = [] // State variable to store fetched postules

    var body: some View {
        List(postules) { postule in
            VStack(alignment: .leading) {
                Text("Nom: \(postule.nom)")
                Text("Prenom: \(postule.prenom)")
                // Display CV image using AsyncImage
                AsyncImage(url: URL(string: postule.cv)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100) // Adjust the height as needed
                    case .failure:
                        // Handle error state if image fails to load
                        Text("Failed to load image")
                    case .empty:
                        // Placeholder or loading state
                        Text("Loading...")
                    @unknown default:
                        // Handle unknown state
                        Text("Unknown state")
                    }
                }
            }
        }
        .navigationBarTitle("Postules", displayMode: .inline)
        .onAppear {
            // Fetch postules for the given opportunity ID (oppId) from the backend
            fetchPostules()
        }
    }

    private func fetchPostules() {
        let url = URL(string: "http://192.168.135.238:8000/postule/\(oppId)")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([Postule].self, from: data)
                
                // Update the state variable with the fetched postules
                DispatchQueue.main.async {
                    postules = decodedData
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }
}

struct PostulesListView_Previews: PreviewProvider {
    static var previews: some View {
        PostulesListView(oppId: "1")
    }
}
