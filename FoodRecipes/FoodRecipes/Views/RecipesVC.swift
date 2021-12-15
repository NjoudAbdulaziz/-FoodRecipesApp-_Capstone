//
//  RecipesVC.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 10/05/1443 AH.
//

import UIKit

class RecipesVC: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titel: UILabel!
    @IBOutlet weak var Ingredients: UILabel!
    @IBOutlet weak var detilesIngredients: UILabel!
    @IBOutlet weak var method: UILabel!
    @IBOutlet weak var detilsMethod: UILabel!
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
