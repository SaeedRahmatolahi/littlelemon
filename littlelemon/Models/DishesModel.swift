//
//  DishesModel.swift
//  littlelemon
//
//  Created by Saeed Rahmatolahi on 6/8/2566 BE.
//

import Foundation
import CoreData


@MainActor
class DishesModel: ObservableObject {
    
    @Published var menuItems = [MenuItem]()
    
    
    func reload(_ coreDataContext:NSManagedObjectContext) async {
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
        let urlSession = URLSession.shared
        
        do {
            let (data, _) = try await urlSession.data(from: url)
            print(String(data: data, encoding: .utf8)!)
            let fullMenu = try JSONDecoder().decode(MenuList.self, from: data)
            menuItems = fullMenu.menu
            Dish.deleteAll(coreDataContext)
            Dish.createDishesFrom(menuItems:menuItems, coreDataContext)
        }
        catch {
            print(error)
        }
    }
}



func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    return encoder
}


extension URLSession {
    fileprivate func codableTask<T: Decodable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
    
    func itemsTask(with url: URL, completionHandler: @escaping (MenuList?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}

