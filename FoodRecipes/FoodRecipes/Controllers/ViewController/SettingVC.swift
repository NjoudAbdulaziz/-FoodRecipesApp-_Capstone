//
//  SettingsVC.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 30/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore


class SettingsVC: UIViewController {
    
    //IBOutlet
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var signOutBtn: UIButton!
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var innerFrame: UIImageView!
    @IBOutlet weak var switchBackgroundView: UIView!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        
        // Set switch status
        darkModeSwitch.isOn = UserInterfaceStyleManager.shared.currentStyle == .dark
        // Start observing style change
        startObserving(&UserInterfaceStyleManager.shared)
  
        
        //get user information from fireStor and put it into user Profaile
        UserApi.getUser(uid: Auth.auth().currentUser?.uid ?? "") { user in
            self.userName.text = user.userName
            self.userEmailLbl.text = user.email
        }
    }

    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        signOutBtn.layer.masksToBounds = true
        signOutBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        signOutBtn.layer.cornerRadius = 25
        signOutBtn.layer.cornerCurve = .continuous
        
        switchBackgroundView.layer.masksToBounds = true
        switchBackgroundView.layer.cornerRadius = 25
        switchBackgroundView.layer.cornerCurve = .continuous

        containerView.layer.cornerRadius = 25
        containerView.backgroundColor = .white
        containerView.layer.shadowColor = UIColor.darkGray.cgColor
        containerView.layer.shadowOpacity = 0.7
        containerView.layer.shadowRadius = 25
        containerView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)

        innerFrame.clipsToBounds = true
        innerFrame.layer.cornerRadius = 25

    }
    
    @IBAction func clickSwitch(_ sender: UISwitch) {
        
        let darkModeOn = sender.isOn
        // Store in UserDefaults
        UserDefaults.standard.set(darkModeOn, forKey: UserInterfaceStyleManager.userInterfaceStyleDarkModeOn)
        
        // Update interface style
        UserInterfaceStyleManager.shared.updateUserInterfaceStyle(darkModeOn)

    }

    
    @IBAction func signOutBtn(_ sender: UIButton) {
     do {
    try Auth.auth().signOut()
    let mainView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "firstPage") as! SignIn_SignUpVC
        mainView.modalPresentationStyle = .fullScreen
        self.present(mainView, animated: true, completion: nil)
         
                }
                  catch let signOutError as NSError {
                    print("Eroor logOut : %@" , signOutError)
               }
           }
       }
