//
//  UserProfile.swift
//  Restaurant
//
//  Created by sokolli on 2/23/25.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentation

    @AppStorage(kFirstName) private var firstName = ""
    @AppStorage(kLastName) private var lastName = ""
    @AppStorage(kEmail) private var email = ""

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray, lineWidth: 1)

            VStack {
                Spacer()

                Text("Personal Information")
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text("Avatar")
                    .font(.callout)
                    .foregroundColor(.gray)
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack {
                    Image("Profile")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 90)
                        .padding(.trailing)

                    Button(action: {
                        print("Change Profile Picture")
                    }) {
                        Text("Change")
                            .font(.callout)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.primaryColor1)
                    }
                    Button(action: {
                        print("Remove Profile Picture")
                    }) {
                        Text("Remove")
                            .font(.callout)
                            .foregroundColor(.gray)
                            .padding()
                            .background(.white)
                            .border(Color.primaryColor1)
                    }
                }

                VStack(alignment: .leading) {
                    Text("First Name")
                        .foregroundColor(.gray)
                        .bold()
                    TextField("First Name", text: $firstName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disabled(true)

                    Text("Last Name")
                        .foregroundColor(.gray)
                        .bold()
                    TextField("Last Name", text: $lastName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disabled(true)

                    Text("Email")
                        .foregroundColor(.gray)
                        .bold()
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disabled(true)
                }
                .padding()

                Spacer()

                Button(action: {
                    UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                    self.presentation.wrappedValue.dismiss()
                }) {
                    Text("Logout")
                        .foregroundColor(Color.primaryColor1)
                        .padding()
                        .bold()
                        .padding(.trailing, 110)
                        .padding(.leading, 110)
                        .background(Color.primaryColor2)
                        .cornerRadius(10)
                }

                Spacer()
            }
        }
        .padding(10)
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
