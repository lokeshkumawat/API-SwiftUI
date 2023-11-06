//
//  CommonTextField.swift
//  DemoUI
//
//  Created by MR Tailor on 19/10/23.
//

import SwiftUI

struct CommonTextField: View {
    @Binding var text: String
     var hint: String
     var keyBoard: UIKeyboardType

    var body: some View {
        TextField(hint, text: $text)
            .backgroundStyle(Color("textFieldBackground"))
            .foregroundColor(Color("textColor"))
            .frame(height: 34)
            .padding(.all,8)
            .keyboardType(keyBoard)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color("textColor"), lineWidth: 2))
    }
}

