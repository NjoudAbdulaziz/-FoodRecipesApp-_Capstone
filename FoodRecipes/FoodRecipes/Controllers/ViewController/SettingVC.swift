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
    
    var user : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        
        UserApi.getUser(uid: Auth.auth().currentUser?.uid ?? "") { user in
            self.userName.text = user.userName
            self.userEmailLbl.text = user.email
        }
    }

    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
     //   view.addSubview(indicatorView)
        signOutBtn.layer.masksToBounds = true
      //  signOutBtn.titleLabel?.font = UIFont.robotoBold(size: 20)
      //  signOutBtn.applyGradient(isVertical: false, colorArray: [.orange1Color, .orange2Color])
        
        signOutBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        signOutBtn.tintColor = .white
        signOutBtn.layer.cornerRadius = 25
        signOutBtn.layer.cornerCurve = .continuous

        containerView.layer.cornerRadius = 25
        containerView.backgroundColor = .white
        containerView.layer.shadowColor = UIColor.darkGray.cgColor
        containerView.layer.shadowOpacity = 0.7
        containerView.layer.shadowRadius = 25
        containerView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)

        innerFrame.clipsToBounds = true
        innerFrame.layer.cornerRadius = 25
//        innerFrame.applyGradient(isVertical: true, colorArray: [.orange1Color, .orange2Color])
    }
    
//    @IBAction func clickSwitch(_ sender: UISwitch) {
//
//            if #available(iOS 15.0, *) {
//                let appDelegate = UIApplication.shared.windows.first
//
//                if sender.isOn {
//                    appDelegate?.overrideUserInterfaceStyle = .dark
//                    return
//                }
//                appDelegate?.overrideUserInterfaceStyle = .light
//                return
//            }else{
//
//            }
//
//    }

    
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
