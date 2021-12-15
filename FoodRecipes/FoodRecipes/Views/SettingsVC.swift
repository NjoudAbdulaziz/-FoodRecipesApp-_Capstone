//
//  SettingsVC.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 09/05/1443 AH.
//

import UIKit
import FirebaseAuth
import Firebase
class SettingsVC: UIViewController {

    @IBOutlet weak var tabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func signOutBtn(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "logOut", sender: nil)
        }
        catch let signOutError as NSError {
            print("Eroor logOut : %@" , signOutError)
        }
    }
}
