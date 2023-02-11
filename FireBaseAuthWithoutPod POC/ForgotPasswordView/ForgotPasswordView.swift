//
//  ForgotPasswordView.swift
//  FireBaseAuthWithoutPod POC
//
//  Created by Guru Mahan on 11/02/23.
//

import SwiftUI
import Firebase
struct ForgotPasswordView: View {
    @State var registerEmail = ""
    @State var StatusMessage = ""
    @State var errorMessage = false
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack{
            LinearGradient(colors: [Color(hex: "1A7BDC").opacity(0.85), Color(hex: "56B8FF").opacity(0.85)], startPoint: .leading, endPoint: .trailing)
                .edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    
                    Image("digiClassIconWhite")
                        .foregroundColor(.white)
                    
                    Text("DigiClass")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                }
                VStack{
                  Text("Forgot Password")
                        .foregroundColor(.black.opacity(0.7))
                        .padding()
                    TextField("Enter Registered Email", text: $registerEmail)
                        .padding()
                        .frame(height: 40)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.35)))
                    Button {
                        if !registerEmail.isEmpty{
                            Auth.auth().sendPasswordReset(withEmail: registerEmail){ err in
                                if let error = err{
                                    self.StatusMessage = "\(error)"
                                    errorMessage = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                                        errorMessage = false
                                    }
                                    
                                }else{
                                    
                                    StatusMessage = "Password Changed"
                                    errorMessage = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                                        errorMessage = false
                                        if presentationMode.wrappedValue.isPresented {
                                            presentationMode.wrappedValue.dismiss()
                                        }
                                    }
                                }
                            }
                        }
                    } label: {
                        Text("Send")
                            .frame(maxWidth: .infinity,maxHeight:40)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(20)
                            .padding(20)
                    }
                    if errorMessage{
                        displayAlertMessage(userMessage: StatusMessage)
                    }
                 Spacer()
                  
                }
                .padding()
                    .frame(maxWidth: .infinity,maxHeight: 500)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding()
            }
           
        }.edgesIgnoringSafeArea(.all)
    }
    @ViewBuilder func displayAlertMessage(userMessage:String) -> some View{
        VStack{
            Text("\(userMessage)")
                .foregroundColor(Color(UIColor.red.withAlphaComponent(0.75)))
                .font(Font.custom("Roboto-Regular", size: 14))
        }
    }
    
}


struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
