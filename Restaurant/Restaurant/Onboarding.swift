//
//  Home.swift
//  Restaurant
//
//  Created by sokolli on 2/23/25.
//


import SwiftUI

let kFirstName = "firstName"
let kLastName = "lastName"
let kEmail = "email"
let kIsLoggedIn = "kIsLoggedIn"

enum FocusableField: Hashable {
    case firstName, lastName, email
}

struct Onboarding: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var isLoggedIn = UserDefaults.standard.bool(forKey: kIsLoggedIn)
    @State private var errorMessage: String? = nil
    @FocusState private var focusedField: FocusableField?

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Hero()
                        .padding(.bottom, 20)

                    VStack(alignment: .leading) {
                        NavigationLink(destination: Home(), isActive: $isLoggedIn) { }

                        inputField(title: "First name *", text: $firstName, focus: .firstName)
                        inputField(title: "Last name *", text: $lastName, focus: .lastName)
                        inputField(title: "E-mail *", text: $email, focus: .email)
                            .keyboardType(.emailAddress)
                    }
                    .padding(.horizontal)
                    .textFieldStyle(.roundedBorder)
                    .disableAutocorrection(true)

                    Button(action: registerUser) {
                        Text("Register")
                            .font(.headline)
                            .foregroundColor(Color.primaryColor1)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.primaryColor2)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)

                    NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                        EmptyView()
                    }
                }
                .padding()
                .alert(item: $errorMessage) { error in
                    Alert(title: Text("Validation Error"), message: Text(error), dismissButton: .default(Text("OK")))
                }
                .onAppear {
                    if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                        isLoggedIn = true
                    }
                    focusedField = .firstName
                }
            }
        }
    }

    private func inputField(title: String, text: Binding<String>, focus: FocusableField) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(.gray)

            TextField(title, text: text)
                .focused($focusedField, equals: focus)
                .padding(.vertical, 8)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding(.bottom, 10) 
    }

    private func registerUser() {
        guard !firstName.isEmpty else {
            errorMessage = "First name cannot be empty."
            focusedField = .firstName
            return
        }
        guard !lastName.isEmpty else {
            errorMessage = "Last name cannot be empty."
            focusedField = .lastName
            return
        }
        guard !email.isEmpty else {
            errorMessage = "Email cannot be empty."
            focusedField = .email
            return
        }
        guard isValidEmail(email) else {
            errorMessage = "Please enter a valid email address."
            focusedField = .email
            return
        }

        UserDefaults.standard.set(firstName, forKey: kFirstName)
        UserDefaults.standard.set(lastName, forKey: kLastName)
        UserDefaults.standard.set(email, forKey: kEmail)
        UserDefaults.standard.set(true, forKey: kIsLoggedIn)

        isLoggedIn = true
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}


extension String: @retroactive Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}
