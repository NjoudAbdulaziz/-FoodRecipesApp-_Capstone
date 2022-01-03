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
    //UIView Properties.....
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
                if let eerror = error {
                    let alert = UIAlertController(title: "login failed", message: "couldn't find your Account!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self?.present(alert, animated: true)
                    
                   
                }else{
                    self?.goToMainPage()
                }
                
            }
        }
    }

    
    private func goToMainPage(){
      let mainView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "main") as! MainVC
      mainView.modalPresentationStyle = .fullScreen
      self.present(mainView, animated: true, completion: nil)
    }
    
}
