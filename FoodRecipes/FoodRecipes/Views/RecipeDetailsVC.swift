//
//  RecipeDetailsVC.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 29/05/1443 AH.
//

import UIKit

class RecipeDetailsVC: UIViewController {

    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeCategoryLbl: UILabel!
    @IBOutlet weak var recipeTitleLbl: UILabel!
    @IBOutlet weak var timerImage: UIImageView!
    @IBOutlet weak var timeOfRecipeLbl: UILabel!
    @IBOutlet weak var hardIcon: UIImageView!
    @IBOutlet weak var hardOfRecipesLbl: UILabel!
    @IBOutlet weak var numberOfPeopleIcon: UIImageView!
    @IBOutlet weak var numberOfPepoleLbl: UILabel!
    @IBOutlet weak var recipeIngredients: UILabel!
    @IBOutlet weak var recipeIngredientsDetails: UILabel!
    @IBOutlet weak var recipeInstructions: UILabel!
    @IBOutlet weak var recipeInstructionsDetails: UILabel!
    
    var recipe : Recipe!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func trendingView() {
    
    }
    
    @IBAction func recipeSavedBtnClicked(_ sender: Any) {
        
        
    }

    @IBAction func shareRecipeBtnClicked(_ sender: UIButton) {
    }
}
