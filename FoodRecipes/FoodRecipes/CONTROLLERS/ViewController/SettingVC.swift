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
    
    //MARK:-Outlets
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var signOutBtn: UIButton!
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var innerFrame: UIImageView!
    @IBOutlet weak var switchBackgroundView: UIView!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var changeLanguageBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Side Menu Btn
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
        //Change properties of Sign Out Btn
        signOutBtn.layer.masksToBounds = true
        signOutBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        signOutBtn.layer.cornerRadius = 25
        signOutBtn.layer.cornerCurve = .continuous
        
        //Change properties of Change Language Btn
        changeLanguageBtn.layer.masksToBounds = true
        changeLanguageBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        changeLanguageBtn.layer.cornerRadius = 25
        changeLanguageBtn.layer.cornerCurve = .continuous
        
        //Change properties of Switch Background View
        switchBackgroundView.layer.masksToBounds = true
        switchBackgroundView.layer.cornerRadius = 25
        switchBackgroundView.layer.cornerCurve = .continuous
        
        //Change properties of Container View
        containerView.layer.cornerRadius = 25
        containerView.backgroundColor = .white
        containerView.layer.shadowColor = UIColor.darkGray.cgColor
        containerView.layer.shadowOpacity = 0.7
        containerView.layer.shadowRadius = 25
        containerView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        
        //Change properties of innerFrame
        innerFrame.clipsToBounds = true
        innerFrame.layer.cornerRadius = 25

    }
    
// -------------------------------------------------------------------------
    // MARK: Actions

    // Switch Dark/Light Mode
    @IBAction func clickSwitch(_ sender: UISwitch) {
        
        let darkModeOn = sender.isOn
        // Store in UserDefaults
        UserDefaults.standard.set(darkModeOn, forKey: UserInterfaceStyleManager.userInterfaceStyleDarkModeOn)
        
        // Update interface style
        UserInterfaceStyleManager.shared.updateUserInterfaceStyle(darkModeOn)

    }

    // Sign out
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
    

    //Change Language Btn Pressed
    @IBAction func Language(_ sender: Any) {
      let chengelangu = UIAlertController(title: NSLocalizedString("The application will be restarted".localized, comment: ""), message: NSLocalizedString( "Please choose the language".localized,comment: ""), preferredStyle: .actionSheet)
    chengelangu.addAction(UIAlertAction(title: "Einglish".localized, style: .default, handler: { action in
       let currentlang = Locale.current.languageCode
       let newLanguage = currentlang == "en" ? "ar" : "en"
       UserDefaults.standard.setValue([newLanguage], forKey: "AppleLanguages")
       exit(0)
      }))
    chengelangu.addAction(UIAlertAction(title: "Arabic".localized, style: .default, handler: {action in
       let currentlang = Locale.current.languageCode
       let newLanguage = currentlang == "en" ? "ar" : "ar"
       UserDefaults.standard.setValue([newLanguage], forKey: "AppleLanguages")
       exit(0)
      }))
    chengelangu.addAction(UIAlertAction(title:NSLocalizedString("Cancel".localized, comment: ""), style: .cancel, handler: nil))
      present(chengelangu, animated: true, completion: nil)
     }
}


