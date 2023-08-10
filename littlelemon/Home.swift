//
//  Home.swift
//  littlelemon
//
//  Created by Saeed Rahmatolahi on 10/8/2566 BE.
//

import SwiftUI

struct Home: View {
    var body: some View {
        TabView {
            Menu().tabItem {
                Text("Menu")
                Image(systemName: "list.dash")
            }.navigationBarHidden(true)
            UserProfile().tabItem {
                Text("Profile")
                Image(systemName: "square.and.pencil")
            }.navigationBarHidden(true)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
