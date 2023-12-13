//
//  LoginView.swift
//  GestionUser
//
//  Created by ayouboueslati on 28/11/2023.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var isNavigationActive = false

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                VStack {
                    Image("logo (2)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 120)
                        .padding(.bottom, 30)

                    VStack(spacing: 20) {
                        TextField("Username", text: $viewModel.email)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))
                            .padding(.bottom, 20)

                        SecureField("Password", text: $viewModel.password)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))
                            .padding(.bottom, 20)

                        HStack {
                            Spacer()
                            NavigationLink(destination: ForgotPasswordView()) {
                                Text("Forgot Password?")
                                    .foregroundColor(.blue)
                            }
                        }

                    }
                    .padding(.horizontal, 30)

                    Button(action: {
                        if !viewModel.email.isEmpty && !viewModel.password.isEmpty {
                                                    viewModel.loginUser()
                                                    isNavigationActive = true // Activate the navigation
                                                } else {
                                                    // Handle empty fields or show an alert
                                                    print("Fill in both email and password.")
                                                }
                    }) {
                        Text("Login")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                    }
                    .padding(.bottom, 20)
                    .background(NavigationLink("", destination: EditProfileView(), isActive: $isNavigationActive).hidden())
                    HStack(spacing: 20) {
                        Button(action: {
                            // Perform Facebook login action here
                            print("Login with Facebook tapped")
                        }) {
                            Image("facebook-icon") // Replace with your Facebook icon image
                                .resizable()
                                .frame(width: 30, height: 30)
                        }

                        Button(action: {
                            // Perform Google login action here
                            print("Login with Google tapped")
                        }) {
                            Image("google-icon") // Replace with your Google icon image
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    }

                    Spacer()

                    NavigationLink(destination: RegisterView()) {
                        Text("Don't have an account? Register")
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 10)
                .padding()
                .navigationBarTitle("Login", displayMode: .inline)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

