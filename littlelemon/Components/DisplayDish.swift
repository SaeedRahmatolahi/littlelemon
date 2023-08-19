//
//  DisplayDish.swift
//  littlelemon
//
//  Created by Saeed Rahmatolahi on 6/8/2566 BE.
//

import SwiftUI


struct DisplayDish: View {
    @ObservedObject private var dish:Dish
    init(_ dish:Dish) {
        self.dish = dish
    }
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, content: {
                Text(dish.title ?? "")
                    .padding([.top, .bottom], 7)
                Text(dish.dishDescription ?? "").padding([.bottom], 7)
                Text(dish.formatPrice())
                    .monospaced()
                    .font(.callout)
            })
            Spacer()
            
            if dish.image != nil {
                AsyncImage(url: URL(string: dish.image!)!) { image in
                    image.resizable()
                } placeholder: {
                    ZStack {
                        LittleLemonImageView(imageName:"little-lemon-logo-grey")
                        ProgressView()
                    }
                }
                .frame(width: 50, height: 50).cornerRadius(5)
            }
        }
        .contentShape(Rectangle())
    }
}

struct DisplayDish_Previews: PreviewProvider {
    static let context = PersistenceController.shared.container.viewContext
    let dish = Dish(context: context)
    static var previews: some View {
        DisplayDish(oneDish())
    }
    static func oneDish() -> Dish {
        let dish = Dish(context: context)
        dish.title = "Hummus"
        dish.price = "10"
        dish.dishDescription = "Extra Large"
        return dish
    }
}

