//
//  PasswordField.swift
//  FireBaseValidateEmail$Passord
//
//  Created by Guru Mahan on 07/02/23.
//

import Foundation
import SwiftUI

struct PasswordField: View {
    @Binding var password: String
    @State var placeHolderText: String = "Enter Password"
    @State private var showandHide = false
    var body: some View {
        VStack {
            HStack {
                if showandHide {
                    TextField(placeHolderText, text: $password)
                }else {
                    SecureField(placeHolderText, text: $password)
                }
                
                Button {
                    self.showandHide.toggle()
                } label: {
                    Image(systemName: showandHide ? "eye.fill" : "eye.slash.fill")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 25, height: 18 )
                        .foregroundColor(Color(hex: "#9CA3AF")
                            .opacity(0.8))
                }
            }
            .autocapitalization(.none)
                                .font(Font.custom("Roboto-Regular", size: 16))
                                .padding()
                                .frame(height: 48)
                                .background(RoundedRectangle(cornerRadius: 5).stroke(Color(hex: "D1D5DB")))
        }
    }
}
