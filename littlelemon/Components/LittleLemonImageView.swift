//
//  LittleLemonImageView.swift
//  littlelemon
//
//  Created by Saeed Rahmatolahi on 18/8/2566 BE.
//

import SwiftUI

struct LittleLemonImageView: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
    }
}
