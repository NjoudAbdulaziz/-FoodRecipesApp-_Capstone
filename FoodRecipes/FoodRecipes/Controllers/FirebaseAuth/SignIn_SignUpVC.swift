//
//  LogOutVC.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 08/05/1443 AH.
//

import UIKit

class SignIn_SignUpVC: UIViewController {

    //UIView Properties...
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var dontHaveAccountLabel: UILabel!
    @IBOutlet weak var signUpBtn: UIButton!
    
    // First loading Func....
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupProperties()
        //Background of The SignIn_SignUpVC Page
        imageView.image = UIImage(named: "1")
    }
    
    @IBAction func signInBtnClick(_ sender: Any) {
        performSegue(withIdentifier: "SignIn", sender: nil)

    }
    
    @IBAction func signUpBtnClick(_ sender: Any) {
       performSegue(withIdentifier: "SignUp", sender: nil)

    }
    
    //Setup UI elements...
    func SetupProperties() {
        
        //SignIn Button...
        signInBtn.layer.cornerRadius = signInBtn.layer.frame.height/2
        
        //SignUp Button...
        signUpBtn.layer.borderWidth = 2
        signUpBtn.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1.0)
        signUpBtn.layer.cornerRadius = signUpBtn.layer.frame.height/2
    }
}
