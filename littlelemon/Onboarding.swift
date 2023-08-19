//
//  Onboarding.swift
//  littlelemon
//
//  Created by Saeed Rahmatolahi on 9/8/2566 BE.
//

import SwiftUI

struct Onboarding: View {
    
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var isLoggedIn = false
    
    var body: some View {
        NavigationView {
            ZStack {
                AppColors.secondary
                VStack {
                    NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                        EmptyView()
                    }
                    LittleLemonImageView(imageName:"little-lemon-logo-grey")
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150)
                                .clipped()
                    LittleLemonTextField(title: Texts.firstName, text: $firstName)
                    LittleLemonTextField(title: Texts.lastName, text: $lastName)
                    LittleLemonTextField(title: Texts.email, text: $email)
                    Button(Texts.register) {
                        if !(firstName.isEmpty && lastName.isEmpty && email.isEmpty) && email.isValidEmail {
                            UserDefaults.saveUserData(firstName: firstName, lastName: lastName, email: email)
                                isLoggedIn = true
                            UserDefaults.save(value: true, key: Keys.kIsLoggedIn)
                        }
                    }.padding(10)
                        .background(AppColors.primary)
                        .foregroundColor(AppColors.secondary).cornerRadius(10)
                }
            }.ignoresSafeArea(.all)
        }.onAppear {
            if UserDefaults.standard.bool(forKey: Keys.kIsLoggedIn) {
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
