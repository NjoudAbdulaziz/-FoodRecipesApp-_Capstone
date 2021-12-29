//
//  SettingsVC.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 09/05/1443 AH.
//

import UIKit
class SettingsVC: UIViewController {

    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
       
    }
    
}
//    @IBAction func signOutBtn(_ sender: UIButton) {
//        do {
//            try Auth.auth().signOut()
//                  let mainView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "firstPage") as! SignIn_SignUpVC
//                  mainView.modalPresentationStyle = .fullScreen
//                  self.present(mainView, animated: true, completion: nil)
//
//
//        }
//        catch let signOutError as NSError {
//            print("Eroor logOut : %@" , signOutError)
//        }
//    }
//}
