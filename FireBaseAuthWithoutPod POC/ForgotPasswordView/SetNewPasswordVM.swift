//
//  SetNewPasswordVM.swift
//  FireBaseAuthWithoutPod POC
//
//  Created by Guru Mahan on 13/02/23.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore

class SetNewPasswordVM: ObservableObject {
    @Published var emailId = ""
    @Published var passwordChange = ""
    func getinfo(){
        
        func updateUser(user: User) {
            Auth.auth().updateCurrentUser(user) { error in
                if let error = error {
                    print("Error when trying to update the user: \(error.localizedDescription)")
                }
            }
            
            
            let info = Firestore.firestore()
            let userid = Auth.auth().currentUser?.uid
            info.collection("user").whereField("email", isEqualTo: emailId ).addSnapshotListener {  snap , err in
                if let error = err{
                    print(error)
                    return
                }
                for i in snap!.documentChanges{
                    let password = i.document.get("password") as! String
                    DispatchQueue.main.async {
                        self.passwordChange = password
                    }
                }
            }
        }
    }
}
