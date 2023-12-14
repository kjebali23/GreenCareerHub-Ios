//
//  OppAdd.swift
//  gestion_entreprise
//
//  Created by khalil on 2/12/2023.
//

// OppAdd.swift
// OppAdd.swift
import SwiftUI

struct OppAdd: View {
    @State private var textField1: String = ""
    @State private var textField2: String = ""
    @State private var textField3: String = ""
    @State private var textField4: String = ""
    @State private var selectedContractType: String = "Type 1"
    @State private var selectedDate: Date = Date()
    @State private var numberField: String = ""

    var body: some View {
        Form {
            Section(header: Text("put logo")) {
                TextField("your logo", text: $textField1)
            }

            Section(header: Text("Poste ")) {
                TextField("Poste", text: $textField2)
            }

            Section(header: Text("votre sociéte")) {
                TextField("nom de votre société", text: $textField3)
            }

            Section(header: Text("description du poste")) {
                TextField("description du poste", text: $textField4)
            }

            Section(header: Text("Contract Type")) {
                Picker("Select Contract Type", selection: $selectedContractType) {
                    Text("CDD").tag("CDD")
                    Text("CDI").tag("CDI")
                    Text("Alternance").tag("Alternance")
                    Text("Stagiare").tag("Stagiare")
                }
                .pickerStyle(SegmentedPickerStyle())
            }

            Section(header: Text("date limite de postuler")) {
                DatePicker("Choose Date", selection: $selectedDate, in: Date()..., displayedComponents: .date)
            }

            Section(header: Text("Salaire")) {
                TextField("Salaire", text: $numberField)
                    .keyboardType(.numberPad)
            }

            Section {
                Button("Save Opportunity") {
                    // Call the networking service to add the opportunity
                    saveOpportunity()
                }
            }
        }
        .navigationTitle("Add Opportunity")
    }

    // Function to save opportunity using the networking service
    private func saveOpportunity() {
        let newOpportunity = Opportunity(
            id: UUID().uuidString,
            poste: textField2,
            nom: textField3,
            salaire: Double(numberField) ?? 0.0,
            logo: textField1,
            type: selectedContractType,
            date: DateFormatter.localizedString(from: selectedDate, dateStyle: .medium, timeStyle: .none),
            desc: textField4
        )

        NetworkingService.shared.addData(opportunity: newOpportunity) { result in
            switch result {
            case .success(let success):
                if success {
                    print("Opportunity added successfully")
                    // Optionally, you can navigate back to the previous screen or perform other actions.
                } else {
                    print("Failed to add opportunity: Data not updated")
                    // Handle the failure, show an alert, etc.
                }
            case .failure(let error):
                print("Failed to add opportunity: \(error)")
                // Handle the failure, show an alert, etc.
            }
        }
    }



}

struct OppAdd_Previews: PreviewProvider {
    static var previews: some View {
        OppAdd()
    }
}
