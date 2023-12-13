//
//  UserProfileView.swift
//  GestionUser
//
//  Created by ayouboueslati on 28/11/2023.
//

import SwiftUI

struct UserProfileView: View {
    @State private var username = "JohnDoe"
    @State private var email = "john.doe@example.com"
    @State private var phoneNumber = "123-456-7890"
    @State private var dateOfBirth = "01/01/1990"
    @State private var cv = "CV not uploaded"

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .padding(.bottom, 20)

                ProfileItem(title: "Username", value: username)
                ProfileItem(title: "Email", value: email)
                ProfileItem(title: "Phone Number", value: phoneNumber)
                ProfileItem(title: "Date of Birth", value: dateOfBirth)
                ProfileItem(title: "CV", value: cv)

                NavigationLink(destination: EditProfileView()) {
                    Text("Edit Profile")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                        .padding(.top, 20)
                }
            }
            .padding()
            .navigationBarTitle("User Profile", displayMode: .inline)
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}

struct ProfileItem: View {
    var title: String
    var value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)

            Text(value)
                .font(.headline)
                .foregroundColor(.gray)
        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.7)))
    }
}
