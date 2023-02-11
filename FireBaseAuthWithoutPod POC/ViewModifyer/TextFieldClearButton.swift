//
//  TextFieldClearButton.swift
//  FireBaseValidateEmail$Passord
//
//  Created by Guru Mahan on 07/02/23.
//

import Foundation

import SwiftUI

struct TextFieldClearButton: ViewModifier {
    @Binding var text: String
    func body(content: Content) -> some View {
        HStack {
            content
        }
    }
}

extension View {
    func clearTextFieldText(text: Binding<String>) -> some View {
        modifier(TextFieldClearButton(text: text))
    }
}

