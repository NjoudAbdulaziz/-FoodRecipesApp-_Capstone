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

    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var newEmailTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    @IBAction func register(_ sender: Any) {
        
        if let email = newEmailTF.text , let password = newPasswordTF.text {
            Auth.auth().createUser(withEmail: email, password: password) {
                AuthResul, error in
                if let errror = error {
                    print(errror)
                }else{
                    self.performSegue(withIdentifier: "main", sender: nil)
                }
            }
    }
    
    
}
}
