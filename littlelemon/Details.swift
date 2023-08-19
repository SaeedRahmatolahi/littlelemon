//
//  Details.swift
//  littlelemon
//
//  Created by Saeed Rahmatolahi on 19/8/2566 BE.
//

import SwiftUI

struct Details: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var dish: Dish
    var body: some View {
        ZStack {
            AppColors.secondary
            VStack {
                if dish.image != nil {
                    AsyncImage(url: URL(string: dish.image!)!) { image in
                        image.resizable().aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ZStack {
                            LittleLemonImageView(imageName:"little-lemon-logo-grey")
                            ProgressView()
                        }
                    }.frame(width: .screenWidth, height: .screenWidth)
                }
                Text(dish.title ?? "").font(.largeTitle).bold()
                    .padding()
                Text(dish.dishDescription ?? "").font(.title2).padding()
                Text(dish.formatPrice())
                    .monospaced()
                    .font(.callout).bold()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(AppColors.primary)
                    }.padding()
                Spacer()
            }.ignoresSafeArea()
        }.navigationBarBackButtonHidden().ignoresSafeArea()
    }
}

struct Details_Previews: PreviewProvider {
    static var previews: some View {
        Details(dish: Dish())
    }
}
