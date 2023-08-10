//
//  Onboarding.swift
//  littlelemon
//
//  Created by Saeed Rahmatolahi on 9/8/2566 BE.
//

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "Email key"
let kIsLoggedIn = "kIsLoggedIn"

import SwiftUI

struct Onboarding: View {
    
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var isLoggedIn = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                TextField("First Name", text: $firstName).disableAutocorrection(true).textFieldStyle(.roundedBorder).padding()
                TextField("Last Name" , text: $lastName).disableAutocorrection(true).textFieldStyle(.roundedBorder).padding()
                TextField("Email", text: $email).disableAutocorrection(true).textFieldStyle(.roundedBorder).padding()
                Button("Register") {
                    if !(firstName.isEmpty && lastName.isEmpty && email.isEmpty) {
                        if email.isValidEmail {
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                            isLoggedIn = true
                            UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        }
                    }
                }.padding(10)
                .background(.green)
                .foregroundColor(.yellow).cornerRadius(10)
            }
        }.onAppear {
            if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                self.isLoggedIn = true
            }
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
