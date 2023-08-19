//
//  Home.swift
//  littlelemon
//
//  Created by Saeed Rahmatolahi on 10/8/2566 BE.
//

import SwiftUI
import CoreData
import UIKit

struct Home: View {
    let persistenceController = PersistenceController.shared
    
    init() {
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().backgroundColor = UIColor(AppColors.secondary)
    }
    
    var body: some View {
        TabView {
            Menu().tabItem {
                Text(Texts.menu)
                Image(systemName: "list.dash")
            }.environment(\.managedObjectContext, persistenceController.container.viewContext)
                .navigationBarHidden(true)
            UserProfile().tabItem {
                Text(Texts.profile)
                Image(systemName: "square.and.pencil")
            }.navigationBarHidden(true)
        }.accentColor(AppColors.primary).background(AppColors.secondary)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
