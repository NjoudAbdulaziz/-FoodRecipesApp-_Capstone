//
//  RecipesVC.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 10/05/1443 AH.
//

import UIKit

class SavedVC: UIViewController {

    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)

    }
    
    
}

//extension UIViewController{
//    static var identifier: String {
//        return String(describing: self)
//    }
//    static func instantiate() -> Self{
//        
//    }
//}
