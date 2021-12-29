//
//  TrendingResipesCollectionViewCell.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 08/05/1443 AH.
//

import UIKit

class TrendingResipesCollectionViewCell: UICollectionViewCell {

    static let identifier = String(describing: TrendingResipesCollectionViewCell.self)

    
    @IBOutlet weak var recipeImageView: UIImageView!
    //Most be btn
    @IBOutlet weak var categoryOfRecipeLabel: UILabel!
    @IBOutlet weak var nameOfRecipe: UILabel!
    @IBOutlet weak var timerIcon: UIImageView!
    @IBOutlet weak var timeofRecipeLabel: UILabel!
    @IBOutlet weak var hardIcon: UIImageView!
    @IBOutlet weak var hardOfRecipeLabel: UILabel!
    @IBOutlet weak var numberOfPeopleIcon: UIImageView!
    @IBOutlet weak var numberOfPeopleLabel: UILabel!
    
    
    func setup(recipe : Recipe){
        
        recipeImageView.image = recipe.recipeImage
        categoryOfRecipeLabel.text = recipe.categoryOfRecipe
        nameOfRecipe.text = recipe.nameOfTheRecipe
        timerIcon.image = recipe.timerIcon
        timeofRecipeLabel.text = recipe.timeofRecipe
        hardIcon.image = recipe.hardIcon
        hardOfRecipeLabel.text = recipe.hardOfRecipe
        numberOfPeopleIcon.image = recipe.numberOfThePeopleIcon
        numberOfPeopleLabel.text = recipe.numberOfPeople

    }
}
