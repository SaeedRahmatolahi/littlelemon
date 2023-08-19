//
//  MenuItem.swift
//  littlelemon
//
//  Created by Saeed Rahmatolahi on 13/8/2566 BE.
//

import Foundation

struct MenuItem: Decodable, Identifiable {
//    var id = UUID()
    let category: String
    let title: String
    let id: Int
    let price: String
    let description: String
    let image: String
}
