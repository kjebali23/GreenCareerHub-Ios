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
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var accesstoken = ""
 
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
                        // Validate email format
                        if !viewModel.email.contains("@") {
                            showAlert = true
                            alertMessage = "Email must contain @ symbol."
                            return
                        }

                        // Validate password length
                        if viewModel.password.count < 6 {
                            showAlert = true
                            alertMessage = "Password must be at least 6 characters."
                            return
                        }

                        // If validations pass, proceed with login
                        viewModel.loginUser()
                        isNavigationActive = true // Activate the navigation
                    }) {
                        Text("Login")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                    }
                    .padding(.bottom, 20)
                    .background(NavigationLink("", destination: UserProfileView(userId: $viewModel.userId.wrappedValue, accessToken: accesstoken), isActive: $isNavigationActive).hidden())


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
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

