//
//  LittleLemonTextField.swift
//  littlelemon
//
//  Created by Saeed Rahmatolahi on 18/8/2566 BE.
//

import Foundation
import SwiftUI

struct LittleLemonTextField: View {
    let title: String
    @Binding var text: String
    var textColor: Color = AppColors.primary
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title).foregroundColor(textColor)
                .font(.headline)
            TextField(title, text: $text)
                .disableAutocorrection(true)
                .textFieldStyle(.roundedBorder)
        }.padding([.leading,.trailing],20)
    }
}
