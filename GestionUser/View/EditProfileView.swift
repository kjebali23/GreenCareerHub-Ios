import SwiftUI

struct EditProfileView: View {
    // Add the necessary properties for editing profile details
    @State private var updatedEmail: String = ""
    @State private var updatedPhoneNumber: String = ""
    @State private var updatedBirthDate: Date = Date()
    @State private var updatedCV: String = ""

    var body: some View {
        Form {
            Section(header: Text("Edit Profile")) {
                TextField("Email", text: $updatedEmail)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                TextField("Phone Number", text: $updatedPhoneNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                DatePicker("Date of Birth", selection: $updatedBirthDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())

                TextField("CV", text: $updatedCV)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

            Section {
                Button("Save Changes") {
                    // Call a function to update the user's profile with the new details
                    saveChanges()
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                .foregroundColor(.white)
            }
        }
        .navigationBarTitle("Edit Profile", displayMode: .inline)
    }

    func saveChanges() {
       
    }

}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
