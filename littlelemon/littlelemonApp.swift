//
//  littlelemonApp.swift
//  littlelemon
//
//  Created by Saeed Rahmatolahi on 5/8/2566 BE.
//

import SwiftUI

@main
struct littlelemonApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            Onboarding()
        }
    }
}
