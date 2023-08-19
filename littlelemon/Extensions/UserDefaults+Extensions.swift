//
//  UserDefaults+Extensions.swift
//  littlelemon
//
//  Created by Saeed Rahmatolahi on 18/8/2566 BE.
//

import Foundation

extension UserDefaults {
    static func saveUserData(firstName: String, lastName: String, email: String) {
        self.save(value: firstName, key: Keys.kFirstName)
        self.save(value: lastName, key: Keys.kLastName)
        self.save(value: email, key: Keys.kEmail)
    }
    
    static func save(value: Any?, key: String) {
        self.standard.set(value, forKey: key)
    }
    
    static func getString(with key: String) -> String {
        return self.standard.string(forKey: key) ?? ""
    }
}
