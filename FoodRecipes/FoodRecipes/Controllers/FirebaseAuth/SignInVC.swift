//
//  SignInVC.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 08/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth
import SwiftMessages

class SignInVC: UIViewController {
  
    //UIView Properties.....
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signInBtn.layer.cornerRadius = signInBtn.layer.frame.height/2
        //Background of The SignInVC Page
        imageView.image = UIImage(named: "1")
        
        // Start observing style change
        startObserving(&UserInterfaceStyleManager.shared)

    }
    // MARK: - Login Button
    
    @IBAction func logInBtn(_ sender: UIButton) {
        
        if email.text?.isEmpty ?? true || password.text?.isEmpty ?? true {
            let message: MessageView = MessageView.viewFromNib(layout: .cardView)
            message.configureTheme(.error)
            message.configureContent(body: "Please fill Email and Password !")
            var config = SwiftMessages.defaultConfig
            config.presentationContext = .view(view)
            config.duration = .automatic
            config.presentationStyle = .top
            SwiftMessages.show(config: config, view: message)
            
            return
           
             } else {
                  login()
            }
        }
    
    // MARK: - Auth Login ..
    
    func login() {
        Auth.auth().signIn(withEmail: email.text ?? "" , password: password.text ?? "") { [weak self] authResult , error in
            guard let strongSelf = self else {return}
            if let error = error {
                
                let message: MessageView = MessageView.viewFromNib(layout: .cardView)
                message.configureTheme(.info)
                message.configureContent(body: "Sorry, Couldn't find your Account!")
                var config = SwiftMessages.defaultConfig
                config.duration = .automatic
                config.presentationStyle = .top
                SwiftMessages.show(config: config, view: message)
                
                return
            
                 } else {
                        self?.goToMainPage()
              }
          }
      }
    
    // MARK: - To Go To The Main Page
    
    private func goToMainPage() {
      let mainView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "main") as! MainVC
      mainView.modalPresentationStyle = .fullScreen
      self.present(mainView, animated: true, completion: nil)
    }
    
}

