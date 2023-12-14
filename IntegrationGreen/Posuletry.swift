import SwiftUI

struct PostuleView: View {
    @State private var nom: String = ""
    @State private var prenom: String = ""
    @State private var selectedImage: UIImage?
    @State private var selectedCVData: Data?
    @State private var isImagePickerPresented: Bool = false
    var opportunityId: String // Add opportunityId property to store the opportunity ID

    var body: some View {
        VStack {
            TextField("Nom", text: $nom)
                .padding()

            TextField("Prénom", text: $prenom)
                .padding()

            Button(action: {
                // Open the image picker when the button is pressed
                self.isImagePickerPresented.toggle()
            }) {
                Text("Importer Image")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            // Display the selected image
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding()
            }

            Button(action: {
                // Call the function to send data to the server (to be implemented)
                self.sendDataToServer()
            }) {
                Text("Enregistrer")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            Spacer() // Add space to push content upwards
        }
        .padding()
        .sheet(isPresented: $isImagePickerPresented) {
            // Use the image picker
            ImagePicker(selectedImage: $selectedImage, isImagePickerPresented: $isImagePickerPresented)
        }
    }

    private func sendDataToServer() {
        guard let url = URL(string: "http://192.168.135.238:8000/postule/postule") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let boundary = "Boundary-\(UUID().uuidString)"
        let contentType = "multipart/form-data; boundary=\(boundary)"
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")

        let body = NSMutableData()

        // Add the image file data to the request body
        if let image = selectedImage, let imageData = image.jpegData(compressionQuality: 1.0) {
            let fileName = "image.jpg"
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"cv\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
        }

        // Add other form data to the request body
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"nom\"\r\n\r\n".data(using: .utf8)!)
        body.append(String(nom).data(using: .utf8)!)
        body.append("\r\n".data(using: .utf8)!)

        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"prenom\"\r\n\r\n".data(using: .utf8)!)
        body.append(String(prenom).data(using: .utf8)!)
        body.append("\r\n".data(using: .utf8)!)

        // Add opportunityId to the request body
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"oppid\"\r\n\r\n".data(using: .utf8)!)
        body.append(opportunityId.data(using: .utf8)!)
        body.append("\r\n".data(using: .utf8)!)

        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = body as Data

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data {
                print(String(data: data, encoding: .utf8) ?? "")
            }
        }.resume()
    }
}

struct PostuleView_Previews: PreviewProvider {
    static var previews: some View {
        PostuleView(opportunityId: "1") // Pass a sample opportunity ID for preview
    }
}
