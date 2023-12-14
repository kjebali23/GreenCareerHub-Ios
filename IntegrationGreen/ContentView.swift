//
//  ContentView.swift
//  IntegrationGreen
//
//  Created by ayouboueslati on 14/12/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isForgotPasswordActive = false
    @State private var isResetPasswordActive = false // Add this state

    var body: some View {
        NavigationView {
            LoginView() // Set LoginView as the root view
                .navigationBarTitle("App Navigation", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
