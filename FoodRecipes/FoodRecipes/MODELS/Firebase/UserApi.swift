//
//  UserApi.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 05/05/1443 AH.
//

import FirebaseFirestore

class UserApi {
    
    static func addUser(name:String,uid:String,email:String,completion: @escaping (Bool) -> Void) {
        
        let refUsers = Firestore.firestore().collection("Users")
        
        
        refUsers.document(uid).setData(User.CreateUser(name: name, email: email))
        
        completion(true)
        
    }
    static func getUser(uid:String,completion: @escaping (User) -> Void) {
       
        let refUsers = Firestore.firestore().collection("Users")
        
        refUsers.document(uid).getDocument { document, error in
            if let document = document, document.exists {
                let user = User.getUser(dict: document.data()!)
                completion(user)
            }
        }
        
    }
    
    static func updateUserInfo(currentUser : User,uid:String,userName:String) {
        
        var name = ""
        
        if userName == currentUser.userName {
            name = currentUser.userName ?? ""
        }else{
            name = userName
        }
        let refUser = Firestore.firestore().collection("Users")
        refUser.document(uid).setData(User.update(userName: name), merge: true)
    }
}
