//
//  LoginView.swift
//  FireBaseValidateEmail$Passord
//
//  Created by Guru Mahan on 07/02/23.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State var emailText:String = ""
    @State var passWordText:String = ""
    @State var isSuccess = false
    @State var moveToSignUpView = false
    @State var message = ""
    @State var showEmailValidationErrorLabel = false
    @State var showPasswordValidationText = false
    @State var showEmailFormat = false
    @State var showPasswordFormat = false
    @State var showEnterYourEmail = false
    @State var showEnterYourPassword = false
    @State var showDonotHaveAccount = false
    @State var isForgotPassword = false
    @State var UserstatusMessage = ""
    
    @StateObject var viewModel = LoginViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(isActive: $moveToSignUpView) {
                    SignUpView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    EmptyView()
                }
                NavigationLink(isActive: $isSuccess) {
                    DashboardView()
                } label: {
                    EmptyView()
                }
                NavigationLink(isActive: $isForgotPassword) {
                    ForgotPasswordView()
                } label: {
                    EmptyView()
                }
                LinearGradient(colors: [Color(hex: "1A7BDC").opacity(0.85), Color(hex: "56B8FF").opacity(0.85)], startPoint: .leading, endPoint: .trailing)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    HStack{
                        Image("digiClassIconWhite")
                            .foregroundColor(.white)
                        Text("DigiClass")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }
                    VStack{
                        bodyView
                    }
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: Color(hex: "111827").opacity(0.4),
                            radius: 2, x: 1, y: 1)
                    .padding()
                    Text(self.UserstatusMessage)
                }
            }
            Spacer()
        }.navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder var bodyView: some View{
        VStack{
            Text("Login")
                .foregroundColor(Color(hex: "666666"))
                .font(Font.custom("Roboto-Medium", size: 18))
                .padding()
            textFieldPanel
            ZStack{
                Button {
                    check()
                } label: {
                    Text("Login")
                        .font(Font.custom("Roboto-Medium", size: 16))
                        .foregroundColor(Color.white)
                        .frame(width: 296, height: 40)
                        .padding([.trailing,.leading], 16.0)
                        .background(Color(hex: "147AFC"))
                        .cornerRadius(4)
                }
                if showDonotHaveAccount{
                    displayAlertMessage(userMessage:"Don't Have Account")
                        .font(Font.custom("Roboto-Medium", size: 16))
                        .foregroundColor(.red)
                        .frame(width: 296, height: 40)
                        .padding([.trailing,.leading], 16.0)
                        .background(Color.white)
                        .cornerRadius(4)
                }
            }
            buttonForgotPassword
            Divider().padding()
            Text("Don't have an account yet?")
                .foregroundColor(Color(hex: "4B5563"))
                .font(Font.custom("Roboto-Regular", size: 18))
            Button {
                moveToSignUpView = true
            } label: {
                Text("Sign Up")
                    .foregroundColor(Color(hex: "147AFC"))
                    .font(Font.custom("Roboto-Medium", size: 16))
                    .foregroundColor(Color.blue)
                    .padding()
            }
        }
    }
    
    @ViewBuilder var buttonForgotPassword: some View {
        Button(action: {
            isForgotPassword = true
        }, label: {
            Text("Forgot Password?")
                .foregroundColor(Color(hex: "147AFC"))
                .font(Font.custom("Roboto-Medium", size: 16))
                .foregroundColor(Color.blue)
                .padding(EdgeInsets(top: 10,
                                    leading: 10,
                                    bottom: 0,
                                    trailing: 10))
        })
    }
    
    @ViewBuilder var textFieldPanel: some View {
        VStack(alignment:.leading){
            VStack(alignment: .leading){
                Text("Email")
                    .foregroundColor(Color(hex: "6B7280"))
                    .font(Font.custom("Roboto-Regular", size: 14))
                TextField("Enter Email Id", text: $emailText)
                    .autocapitalization(.none)
                    .clearTextFieldText(text: $emailText)
                    .font(Font.custom("Roboto-Regular", size: 16))
                    .padding()
                    .frame(height: 48)
                    .background(RoundedRectangle(cornerRadius: 5).stroke(Color(hex: "D1D5DB")))
                emailShowAlertText()
            }.padding()
            VStack(alignment: .leading){
                Text(
                    "PassWord")
                .foregroundColor(Color(hex: "6B7280"))
                .font(Font.custom("Roboto-Regular", size: 14))
                PasswordField(password: $passWordText)
                passwordShowAlertText()
            }.padding()
        }
    }
    
    @ViewBuilder func displayAlertMessage(userMessage:String) -> some View{
        VStack{
            Text("\(userMessage)")
                .foregroundColor(Color(UIColor.red.withAlphaComponent(0.75)))
                .font(Font.custom("Roboto-Regular", size: 14))
        }
    }
    
    @ViewBuilder func emailShowAlertText() -> some View{
        if showEmailValidationErrorLabel{
            Text("Invalid EMail")
        }
        if showEmailFormat{
            displayAlertMessage(userMessage:"Invalid Format" )
        }
        if showEnterYourEmail{
            displayAlertMessage(userMessage: "Enter Your Email" )
        }
    }
    
    @ViewBuilder func passwordShowAlertText() -> some View{
        if showPasswordValidationText{
            displayAlertMessage(userMessage:"Invalid Password" )
        }
        if showPasswordFormat{
            displayAlertMessage(userMessage:"Invalid Format" )
        }
        if showEnterYourPassword{
            displayAlertMessage(userMessage: "Enter Your Password" )
        }
    }
    
    func check(){
        if emailText.isEmpty{
            withAnimation {
                showEnterYourEmail = true
            }
        } else if !emailText.isEmpty{
            showEnterYourEmail = false
            if !viewModel.isValidEmail(testStr: emailText){
                withAnimation {
                    showEmailFormat = true
                    showEmailValidationErrorLabel = false
                }
            }else if viewModel.isValidEmail(testStr: emailText){
                withAnimation {
                    showEmailValidationErrorLabel = false
                    showEmailFormat = false
                }
            }
        }
        if passWordText.isEmpty{
            withAnimation {
                showEnterYourPassword = true
                showPasswordValidationText = false
                showPasswordFormat = false
            }
        }else if !passWordText.isEmpty{
            showEnterYourPassword = false
            if !viewModel.isPasswordValid(passWordText){
                withAnimation {
                    showPasswordValidationText = false
                    showEnterYourPassword = false
                    showPasswordFormat = true
                }
            }else if viewModel.isPasswordValid(passWordText){
                withAnimation {
                    showPasswordValidationText = false
                    showPasswordFormat = false
                    LoginUser()
                }
            }
        }
    }
    
    func LoginUser(){
        Auth.auth().signIn(withEmail: emailText , password: passWordText){result, err in
            if let err = err{
                print("Field to login user:\(err)")
                self.UserstatusMessage = "Field to login user:\(err)"
                showDonotHaveAccount = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    showDonotHaveAccount = false
                }
                return
            }else{
                print("Successfully logged in as user: \(result?.user.uid ?? "")")
                self.UserstatusMessage = "Successfully logged in as user : \(result?.user.uid ?? "")"
                isSuccess = true
                UserDefaults.standard.set(true, forKey: "islogin")
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

