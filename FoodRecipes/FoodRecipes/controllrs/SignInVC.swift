//
//  SignInVC.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 08/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SignInVC: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func logInBtn(_ sender: UIButton) {
        if let email = email.text , let password = password.text{
            Auth.auth().signIn(withEmail: email, password: password) { [weak self]
                AuthResult , error in
                guard let strongSelf = self else {return}
                if let e = error{
                    print(e)
                }else{
                    self?.performSegue(withIdentifier: "mainn", sender: nil)
                }
                
    }
    }
    }
    @IBAction func createNewAcountBtn(_ sender: Any) {
        performSegue(withIdentifier: "signUpPage", sender: nil)
    }
    

}
