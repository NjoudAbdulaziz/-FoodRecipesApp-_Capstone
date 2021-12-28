//
//  SignUpVC.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 05/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SignUpVC: UIViewController {
    
    //UIView Properties...
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var newEmailTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        UserApi.getUser(uid: Auth.auth().currentUser?.uid ?? "") { user in
        //            self.newEmailTF.text = user.email
        //        }
        
        
        
    }
    
    @IBAction func register(_ sender: Any) {
        signUp()
        
    }
    
    func signUp(){
        
        if let email = newEmailTF.text , let password = newPasswordTF.text {
            Auth.auth().createUser(withEmail: email, password: password) {
                (AuthResul, error) in
                guard let user = AuthResul?.user, error == nil else {
                    print("email\(String(describing:AuthResul?.user.email ))")
                    print("uid\(String(describing:AuthResul?.user.uid ))")
                    
                    return
                }
                
                UserApi.addUser(name: self.userNameTF.text ?? "", uid: AuthResul?.user.uid ?? "" , email: self.newEmailTF.text ?? "" , completion: { check in
                    
                    if check {
                        print("Done Saving in Database")
                        
                        self.goTotabBarPage()
                    }
                    else{
                    }
                })
                
            }
        }
    }
    
    private func goTotabBarPage(){
        let mainView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "Home") as! HomeVC
        mainView.modalPresentationStyle = .fullScreen
        self.present(mainView, animated: true, completion: nil)
    }
    
}
