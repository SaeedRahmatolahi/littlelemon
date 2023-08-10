//
//  ContentView.swift
//  littlelemon
//
//  Created by Saeed Rahmatolahi on 5/8/2566 BE.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @ObservedObject var dishesModel = DishesModel()
    @State private var showAlert = false
    @State var searchText = ""

    var body: some View {
        NavigationView {
            FetchedObjects(
                predicate:buildPredicate(),
                sortDescriptors: buildSortDescriptors()) {
                    (dishes: [Dish]) in
                    List {
                        ForEach(dishes, id:\.self) { dish in
                            DisplayDish(dish)
                                .onTapGesture {
                                    showAlert.toggle()
                                }
                        }
                    }
                    .searchable(text: $searchText,
                                prompt: "search...")
                }
        }.task {
            await dishesModel.reload(viewContext)
        }
    }
    
    private func buildPredicate() -> NSPredicate {
        return searchText == "" ?
        NSPredicate(value: true) :
        NSPredicate(format: "name CONTAINS[cd] %@", searchText)
    }
    
    private func buildSortDescriptors() -> [NSSortDescriptor] {
        [NSSortDescriptor(key: "name",
                          ascending: true,
                          selector:
                            #selector(NSString.localizedStandardCompare))]
    }
    
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
