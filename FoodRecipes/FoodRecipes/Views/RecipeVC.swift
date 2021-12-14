//
//  RecipeVC.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 10/05/1443 AH.
//

import UIKit

class RecipeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func addRecipe(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toAddRecipe", sender: nil)

    }
    

}
