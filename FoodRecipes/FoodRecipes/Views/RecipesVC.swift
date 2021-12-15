//
//  RecipesVC.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 10/05/1443 AH.
//

import UIKit

class RecipesVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titel: UITextField!
    @IBOutlet weak var timeToCook: UITextField!
    @IBOutlet weak var serves: UITextField!
    @IBOutlet weak var ingredients: UITextField!
    @IBOutlet weak var steps: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
