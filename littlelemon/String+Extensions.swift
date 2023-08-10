//
//  String+Extensions.swift
//  littlelemon
//
//  Created by Saeed Rahmatolahi on 9/8/2566 BE.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        let parts = self.split(separator: "@")
        guard parts.count == 2 else {
            return false
        }
        let localPart = parts[0]
        guard !localPart.isEmpty else {
            return false
        }
        let domainPart = parts[1]
        guard domainPart.contains(".") else {
            return false
        }
        return true
    }
}
