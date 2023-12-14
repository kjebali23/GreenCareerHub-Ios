//
//  OppListView.swift
//  gestion_entreprise
//
//  Created by khalil on 28/11/2023.
//

// OppListView.swift
import SwiftUI

struct OppListView: View {
    @State private var opportunities: [Opportunity] = []
      @State private var isAddingOpportunity = false

    var body: some View {
        NavigationView {
            List(opportunities, id: \.id) { opp in
                NavigationLink(destination: OppDetailView(opportunity: opp)) {
                    VStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(color: Color.gray, radius: 4, x: 0, y: 2)
                            .frame(height: 150)
                            .overlay(
                                HStack {
                                    if let imageURL = URL(string: opp.logo),
                                       let imageData = try? Data(contentsOf: imageURL),
                                       let uiImage = UIImage(data: imageData) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .frame(width: 100, height: 130)
                                            .cornerRadius(10)
                                    } else {
                                        Color.gray
                                            .frame(width: 100, height: 130)
                                            .cornerRadius(10)
                                    }

                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(opp.poste)
                                            .fontWeight(.bold)
                                            .lineLimit(2)
                                            .minimumScaleFactor(0.5)
                                            .padding(.trailing, 10)

                                        HStack {
                                            Image(systemName: "house")
                                                .foregroundColor(.blue)

                                            Text(opp.nom)
                                                .font(.caption)
                                                .lineLimit(1)
                                                .minimumScaleFactor(0.5)
                                        }

                                        HStack {
                                            Image(systemName: "dollarsign")
                                                .foregroundColor(.blue)

                                            let formattedSalaire = String(format: "%.2f", opp.salaire)

                                            Text(formattedSalaire)
                                                .font(.caption)
                                                .padding(.top, 2)
                                                .minimumScaleFactor(0.5)
                                        }

                                        HStack {
                                            Image(systemName: "timer")
                                                .foregroundColor(.blue)

                                            Text(opp.date ?? "")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                                .minimumScaleFactor(0.5)

                                            Text(opp.type)
                                                .padding(.horizontal, 8)
                                                .font(.caption)
                                                .background(Color.blue)
                                                .foregroundColor(.black)
                                        }
                                    }
                                }
                                .padding()
                            )
                    }
                }
            }
            .onAppear {
                           // Fetch data when the view appears
                           NetworkingService.shared.fetchData { data in
                               DispatchQueue.main.async {
                                   self.opportunities = data ?? []
                               }
                           }
                       }
                       .listStyle(.plain)
                       .navigationTitle("Opportunities")
                       .navigationBarItems(trailing:
                           Button(action: {
                               // Set isAddingOpportunity to true to present OppAdd sheet
                               isAddingOpportunity = true
                           }) {
                               Image(systemName: "plus.circle.fill")
                                   .imageScale(.large)
                           }
                       )
                       .sheet(isPresented: $isAddingOpportunity) {
                           // Present OppAdd as a sheet
                           OppAdd()
                       }
                   }
               }
           }

struct OppListView_Previews: PreviewProvider {
    static var previews: some View {
        OppListView()
    }
}
