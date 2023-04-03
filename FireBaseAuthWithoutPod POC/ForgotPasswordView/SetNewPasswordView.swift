//
//  SetNewPasswordView.swift
//  FireBaseAuthWithoutPod POC
//
//  Created by Guru Mahan on 13/02/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore

struct SetNewPasswordView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var showToast: Bool = false
    @State var toastMessage: String = ""
    @State var isLoaderShown: Bool = false
    @State var newPasswordText = ""
    @State var confirmPassword = ""
    @State var goToLoginView = false
    @ObservedObject var ViewModel = SetNewPasswordVM()
    
        init(email1: String){
            self.ViewModel.emailId = email1
         print("Email====>\(email1)")
           
     }
     
     func saveInfo(){
         let db = Firestore.firestore()
         let email = ViewModel.emailId
       let currentUser = Auth.auth().currentUser
         if  let userId = Auth.auth().currentUser?.uid{
                 db.collection("user").document("\(userId)").updateData(["password": newPasswordText])
                 currentUser?.updatePassword(to: newPasswordText){ err in
                     if let error = err{
                         print("Failure: \(error)")
                     }else{
                         self.goToLoginView = true
                         print("Password changed successfully")
                     }
                 }
         }
     }

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                NavigationLink(isActive: $goToLoginView) {
                    LoginView()
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true)
                } label: {
                    EmptyView()
                }
                LinearGradient(gradient:
                                Gradient(colors: [
                                    Color(hex: "1A7BDC").opacity(0.85),
                                    Color(hex: "56B8FF").opacity(0.85)])
                               ,startPoint: .leading
                               ,endPoint: .trailing)
                .edgesIgnoringSafeArea(.all)
                containerView
                    .padding(.top, 80)
            }
            .edgesIgnoringSafeArea(.all)
            .loader(isShown: $isLoaderShown)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    @ViewBuilder var DCGradientView: some View {
        LinearGradient(gradient: Gradient(colors: [Color(hex: "#1A7BDC"), Color(hex: "#56B8FF")]), startPoint: .leading, endPoint: .trailing)
    }
    
    @ViewBuilder var containerView: some View {
        VStack {
            Image("digiclass")
                .aspectRatio(contentMode: .fit)
            VStack(spacing: 24) {
                headerView
                    .padding(.horizontal, 16)
                newPasswordView
                    .padding(.horizontal, 16)
                conformPasswordView
                    .padding(.horizontal, 16)
                footerView
                    .padding(.horizontal, 16)
            }
            .background(Color.white)
            .cornerRadius(8)
            .padding()
        }
    }
    
    @ViewBuilder var headerView: some View {
        ZStack {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "arrow.backward")
                            .font(Font.system(size: 18,weight: .semibold))
                            .foregroundColor(Color(hex: "#666666"))
                    })
                    Spacer()
                }
            Text("Set New Password")
                .foregroundColor(Color(hex: "#666666"))
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 16)
    }
    
    @ViewBuilder var newPasswordView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("New Password")
                .foregroundColor(Color(hex: "#6B7280"))
            TextField("New Password", text: $newPasswordText)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color(hex: "#D1D5DB"), lineWidth: 1)
            )
 }
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder var conformPasswordView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Confirm Password")
                .foregroundColor(Color(hex: "#6B7280"))
            TextField("Confirm Password", text: $confirmPassword)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color(hex: "#D1D5DB"), lineWidth: 1)
            )
        }
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder var footerView: some View {
        VStack(spacing: 12) {
            Button(action: {
                if !newPasswordText.isEmpty && !confirmPassword.isEmpty {
                    if newPasswordText == confirmPassword {
                        DispatchQueue.main.async {
                            self.saveInfo()
                        }
                    }
                }
            },
                   label: {
                GeometryReader { geometry in
                    Text("Save and continue")
                        .foregroundColor(.white)
                      
                        .frame(width: geometry.size.width,
                               height: geometry.size.height)
                }
            })
            .frame(height: 50)
            .background(Color(hex: "#147AFC"))
            .cornerRadius(5)
        }
        .padding(.bottom, 16)
    }
}

struct SetNewPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        SetNewPasswordView(email1: "false")
    }
}


