//
//  LoginViewModel.swift
//  CoreDataLogin
//
//  Created by Guru Mahan on 01/02/23.
//

import Foundation
import UIKit
import SwiftUI

class LoginViewModel: ObservableObject {
 @State var  emailTextField = ""
 @State var PasswordTextField = ""
    func isPasswordValid(_ password : String) -> Bool{
            let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{3,64}")
            return passwordTest.evaluate(with: password)
        }
    
        func isValidEmail(testStr:String) -> Bool {
            // print("validate calendar: \(testStr)")
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: testStr)
        }
    
    
}

