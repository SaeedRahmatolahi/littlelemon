//
//  Dish+CoreDataClass.swift
//  littlelemon
//
//  Created by Saeed Rahmatolahi on 6/8/2566 BE.
//

import Foundation
import CoreData

@objc(Dish)
public class Dish: NSManagedObject {

    func formatPrice() -> String {
        let spacing = Int(price) ?? 0 < 10 ? " " : ""
        return "$ " + spacing + String(format: "%.2f", price)
    }
    
}
