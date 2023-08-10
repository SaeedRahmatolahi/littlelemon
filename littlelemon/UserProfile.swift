//
//  UserProfile.swift
//  littlelemon
//
//  Created by Saeed Rahmatolahi on 10/8/2566 BE.
//

import SwiftUI

struct UserProfile: View {
    
    let firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    let lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
    let email = UserDefaults.standard.string(forKey: kEmail) ?? ""
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            Text("Personal information")
            Image("profile-image-placeholder")
            Button("Logout") {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }
            Spacer()
            Text(firstName).padding()
            Text(lastName).padding()
            Text(email).padding()

        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
