//
//  SettingsTableVC.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 30/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import SwiftMessages

class SettingsTableVC: UITableViewController {
    
    //IBOutlet
    
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var userEmailTF: UITextField!
    
    var user : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        
        UserApi.getUser(uid: Auth.auth().currentUser?.uid ?? "") { user in
            self.userNameTF.text = user.userName
            self.userEmailTF.text = user.email
        }
    }


    
    @IBAction func clickSwitch(_ sender: UISwitch) {
        
            if #available(iOS 15.0, *) {
                let appDelegate = UIApplication.shared.windows.first
    
                if sender.isOn {
                    appDelegate?.overrideUserInterfaceStyle = .dark
                    return
                }
                appDelegate?.overrideUserInterfaceStyle = .light
                return
            }else{
    
            }
    
    }


    @IBAction func savedBtnPressed(_ sender: UIButton) {
        
       }
    
    @IBAction func cameraBtnPressed(_ sender: Any) {
        
       }
    
    @IBAction func editBtnPressed(_ sender: Any) {
        
        let message: MessageView = MessageView.viewFromNib(layout: .cardView)
        message.configureTheme(.success)
        message.configureContent(body: "Your information has been successfully updated.")
        var config = SwiftMessages.defaultConfig
        config.presentationContext = .view(view)
        config.duration = .automatic
        config.presentationStyle = .top
        SwiftMessages.show(config: config, view: message)
        
        updateInfo()
       }
    
    func  updateInfo() {
        guard let user = user else {return}
        
        UserApi.updateUserInfo(currentUser: user, uid: Auth.auth().currentUser?.uid ?? "", userName: userNameTF.text ?? "")
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
