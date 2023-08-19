//
//  UserProfile.swift
//  littlelemon
//
//  Created by Saeed Rahmatolahi on 10/8/2566 BE.
//

import SwiftUI

struct UserProfile: View {
    
    @State var firstName = UserDefaults.getString(with: Keys.kFirstName)
    @State var lastName = UserDefaults.getString(with: Keys.kLastName)
    @State var email = UserDefaults.getString(with: Keys.kEmail)
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ZStack {
            AppColors.white.ignoresSafeArea(.all)
            VStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1) // Gray border
                    .background(Color.clear)
                    .padding(.all, 15)
                    .overlay(
                        VStack {
                            Text(Texts.personalInformation)
                            LittleLemonImageView(imageName:"Profile")
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100) // Adjust size as needed
                                .clipShape(Circle())
                            Button(Texts.logout) {
                                UserDefaults.save(value: false, key: Keys.kIsLoggedIn)
                                self.presentation.wrappedValue.dismiss()
                            }.frame(width: 200, height: 40).background(AppColors.secondary).cornerRadius(10).foregroundColor(AppColors.primary)
                            LittleLemonTextField(title: Texts.firstName, text: $firstName)
                            LittleLemonTextField(title: Texts.lastName, text: $lastName)
                            LittleLemonTextField(title: Texts.email, text: $email).padding(.bottom,10)
                            Button(Texts.saveChanges) {
                                if !(firstName.isEmpty && lastName.isEmpty && email.isEmpty) && email.isValidEmail {
                                    UserDefaults.saveUserData(firstName: firstName, lastName: lastName, email: email)
                                }
                            }.frame(width: 150, height: 40).background(AppColors.primary).cornerRadius(10).foregroundColor(AppColors.white)
                        }.padding(.all, 10)
                    )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
