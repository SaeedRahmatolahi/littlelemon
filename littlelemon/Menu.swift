//
//  Menu.swift
//  littlelemon
//
//  Created by Saeed Rahmatolahi on 10/8/2566 BE.
//

import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var dishesModel = DishesModel()
    @State private var navigationBarHeight: CGFloat = 0
    @State var searchText = ""
    @State var selectedCategory = ""
    
    var body: some View {
        ZStack {
            VStack {
                Color.white.frame(height: navigationBarHeight).ignoresSafeArea()
                AppColors.primary
            }
            VStack {
                HStack {
                    Spacer()
                    Image("Logo")
                    Spacer()
                    LittleLemonImageView(imageName:"Profile")
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .clipped()
                }.padding()
                VStack {
                    HStack {
                        Text(Texts.littleLemon).font(.system(size: 50)).foregroundColor(AppColors.secondary).fontWeight(.semibold)
                        Spacer()
                    }.padding()
                    HStack {
                        VStack(alignment: .leading) {
                            Text(Texts.chicago).font(Font.system(size: 32)).fontWeight(.regular).foregroundColor(AppColors.white)
                            Text(Texts.restaurantDescription).foregroundColor(AppColors.white)
                        }.padding([.leading, .trailing], 10)
                        LittleLemonImageView(imageName: "HeroImage").frame(width: 100, height: 100).cornerRadius(10).clipped()
                    }.padding([.leading, .trailing], 10)
                }
                TextField(Texts.searchMenu, text: $searchText).disableAutocorrection(true).padding().textFieldStyle(.roundedBorder)
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(Constants.categories, id: \.self) { category in
                            Text(category)
                                .foregroundColor(AppColors.secondary)
                                .padding()
                                .background(AppColors.primary)
                                .cornerRadius(25)
                                .onTapGesture {
                                    (selectedCategory == category) ? (selectedCategory = "") : (selectedCategory = category)
                                }
                        }
                    }
                    .padding()
                }.background(AppColors.white)
                FetchedObjects(
                    predicate:buildPredicate(),
                    sortDescriptors: buildSortDescriptors()) {
                        (dishes: [Dish]) in
                        List {
                            ForEach(dishes, id:\.self) { dish in
                                NavigationLink(destination: Details(dish: dish)) {
                                    DisplayDish(dish).navigationBarHidden(true)
                                }.navigationBarHidden(true)
                            }
                        }
                    }.onAppear {
                        getMenuData()
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                            navigationBarHeight = windowScene.windows.first?.safeAreaInsets.top ?? 0
                            if let navBar = windowScene.windows.first?.rootViewController?.view.viewWithTag(987654) as? UINavigationBar {
                                navigationBarHeight += navBar.frame.height
                            }
                        }
                    }
            }
        }
    }
    
    private func buildPredicate() -> NSPredicate {
        var predicates: [NSPredicate] = []
        
        if !searchText.isEmpty {
            let searchPredicate = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
            predicates.append(searchPredicate)
        }
        
        if !selectedCategory.isEmpty {
            let categoryPredicate = NSPredicate(format: "category CONTAINS[cd] %@", selectedCategory)
            predicates.append(categoryPredicate)
        }
        
        if selectedCategory.isEmpty && searchText.isEmpty {
            predicates.append(NSPredicate(value: true))
        }
        
        return NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
    }
    
    private func buildSortDescriptors() -> [NSSortDescriptor] {
        [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }
    
    func getMenuData() {
        PersistenceController.shared.clearData()
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let data = data {
                do {
                    let menuList = try JSONDecoder().decode(MenuList.self, from: data)
                    print(menuList)
                    for item in menuList.menu {
                        if exists(name: item.title, viewContext) {
                            continue
                        }
                        let dish = Dish(context: viewContext)
                        dish.title = item.title
                        dish.price = item.price
                        dish.image = item.image
                        dish.category = item.category
                        dish.dishDescription = item.description
                    }
                    try? viewContext.save()
                } catch {
                    // Handle decoding error
                    print("Decoding Error: \(error)")
                }
            }
        }
        task.resume()
    }
    
    func exists(name: String,
                _ context:NSManagedObjectContext) -> Bool {
        let request = Dish.request()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", name)
        request.predicate = predicate
        
        do {
            guard let results = try context.fetch(request) as? [Dish]
            else {
                return false
            }
            return results.count > 0
        } catch (let error){
            print(error.localizedDescription)
            return false
        }
    }
    
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
