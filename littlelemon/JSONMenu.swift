//
//  JSONMenu.swift
//  littlelemon
//
//  Created by Saeed Rahmatolahi on 6/8/2566 BE.
//

import Foundation

struct JSONMenu: Codable {
    let menu: [MenuItem]
}


struct MenuItem: Codable {
//    let name: String
    let title: String
    let id: Int
    let price: String
//    let description: String
//    let image: String
}
