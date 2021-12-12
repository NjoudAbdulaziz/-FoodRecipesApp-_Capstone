////
////  ViewController.swift
////  FoodRecipes
////
////  Created by Njoud Alrshidi on 05/05/1443 AH.
////
//
//import UIKit
//import Firebase
//import FirebaseAuth
//import FirebaseFirestore
//     // Do any additional setup after loading the view.
//        }
//        func users(){
//            UserApi.getUser(uid: Auth.auth().currentUser?.uid ?? "") { user in
//                print(user.userName)
//               // self.performSegue(withIdentifier: "", sender: nil)
//            }
//        }
////        func SignIn(email: String,password:String) {
////
////            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
////
////                if let error = error {
////                    print(error.localizedDescription)
////                }
////                if authResult?.user.email != nil {
////
////                }
////                print("email:\(String(describing: authResult?.user.email))")
////                print("uid:\(String(describing: authResult?.user.uid))")
////                // ...
////            }
////        }
//
//    func SignUp(email: String,password:String , confirmPasswordTF : String) {
//        if let email = emailTF.text , let password = passwordTF.text , let confirmPassword = confirmPasswordTF.text , let userNamee = userNameTF.text {
//
//        Auth.auth().createUser(withEmail: email, passwordd: passwordTF , userNamee :userNameTF , password : confirmPasswordTF) { authResult, error in
//
//                print("email:\(String(describing: authResult?.user.email))")
//                print("uid:\(String(describing: authResult?.user.uid))")
//
//                UserApi.addUser(name: userNameTF, uid: authResult?.user.uid ?? "", email: email) { check in
//                    if check {
//                        print("Done saving in Database")
//                    } else {
//
//                    }
//                }
//            }
//        }
//
//
//
//
//
//
//    @IBAction func signUp(_ sender: Any) {
//
//        SignUp(email: emailTF.text ?? "", password:, confirmPasswordTF: confirmPasswordTF.text ?? "")
//
//    }
//
//
//
//
////    func signButton(_ sender: UIButton) {
////
////            SignUp(email: email.text ?? "", password: password.text ?? "")
////
////        }
////
////
////
////    func singIn(_ sender: UIButton) {
////
////            SignIn(email: email.text ?? "", password: password.text ?? "")
////
////        }
//
//    }
//
//
//
//
//
//
//
