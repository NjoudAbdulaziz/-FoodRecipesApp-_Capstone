//
//  RecipesListTableViewCell.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 26/05/1443 AH.
//

import UIKit

class RecipesListTableViewCell: UITableViewCell {

    static let identifier = "RecipesListTableViewCell"
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    func setup(recipe:Recipe) {
        
        recipeImageView.image = recipe.recipeImage
        titleLbl.text = recipe.nameOfTheRecipe
    }
}
