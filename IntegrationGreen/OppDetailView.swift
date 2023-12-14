import SwiftUI

struct OppDetailView: View {
    @State private var isPostuleViewPresented = false
    @State private var isPostulesListViewPresented = false // New state variable

    var opportunity: Opportunity

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if let imageURL = URL(string: opportunity.logo),
                       let imageData = try? Data(contentsOf: imageURL),
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .frame(width: 130, height: 130)
                            .cornerRadius(10)
                            .padding(.top, -10)
                    } else {
                        Color.gray
                            .frame(width: 100, height: 130)
                            .cornerRadius(10)
                            .padding(.top, -10)
                    }

                    Text(opportunity.poste)
                        .padding(.top, 20)
                        .fontWeight(.bold)
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)

                    Text(opportunity.nom)
                        .padding(.top, 20)
                        .font(.caption)

                    HStack(alignment: .firstTextBaseline, spacing: 150) {
                        Text(opportunity.type)
                            .font(.headline)
                            .background(Color.blue)
                            .foregroundColor(.black)

                        Text(String(format: "%.2f", opportunity.salaire))
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                    .padding(.top, 20)
                    .minimumScaleFactor(0.5)

                    VStack {
                        Text(opportunity.desc)
                            .padding()
                            .font(.body)
                            .foregroundColor(.black)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                            .padding(.horizontal)
                            .padding(.top, 30)
                    }

                    // Updated button action to pass opportunity ID to PostuleView
                    NavigationLink(
                        destination: PostuleView(opportunityId: opportunity.id), // Pass opportunity ID to PostuleView
                        isActive: $isPostuleViewPresented
                    ) {
                        EmptyView()
                    }
                    .hidden()

                    Button(action: {
                        // Updated button tap action to pass opportunity ID to PostuleView
                        self.isPostuleViewPresented.toggle()
                    }) {
                        Text("POSTULER")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)

                    // New button to navigate to PostulesListView
                    NavigationLink(
                        destination: PostulesListView(oppId: opportunity.id), // Pass opportunity ID to PostulesListView
                        isActive: $isPostulesListViewPresented
                    ) {
                        EmptyView()
                    }
                    .hidden()

                    Button(action: {
                        // New button tap action to navigate to PostulesListView
                        self.isPostulesListViewPresented.toggle()
                    }) {
                        Text("Voir les postules")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green) // Use a different color or style for this button
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
                .padding()
            }
            .onAppear {
                UINavigationBar.appearance().largeTitleTextAttributes = [
                    .foregroundColor: UIColor.black
                ]
                UINavigationBar.appearance().titleTextAttributes = [
                    .foregroundColor: UIColor.black
                ]
                UINavigationBar.appearance().tintColor = UIColor.black
                UINavigationBar.appearance().barTintColor = UIColor.white
            }
            .navigationBarTitle("Détails", displayMode: .inline)
        }
    }
}

struct OppDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OppDetailView(opportunity: Opportunity(id: "1", poste: "Placeholder Poste", nom: "Placeholder Nom", salaire: 1000.0, logo: "placeholder_logo", type: "Placeholder Type", date: "Nov 22, 2023", desc: "Placeholder Description"))
    }
}


