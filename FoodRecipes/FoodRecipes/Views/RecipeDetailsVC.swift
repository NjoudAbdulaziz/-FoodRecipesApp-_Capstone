//
//  RecipeDetailsVC.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 29/05/1443 AH.
//

import UIKit

class RecipeDetailsVC: UIViewController {
    
    //MARK:-Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var selectedSegmented: UISegmentedControl!
    @IBOutlet weak var ingredientsView: UIStackView!
    @IBOutlet weak var savedButton: UIButton!
    @IBOutlet weak var youTubeButton: UIButton!
    @IBOutlet weak var webButton: UIButton!
    @IBOutlet weak var instructionsTextView: UITextView!
    @IBOutlet weak var tabelView: UITableView!
    
    
    //MARK:-Properties
    
    var shortRecipe:ShortRecipe?
    var ingredients:[RecipeIngredients] = []
    var imageData: Data?
    var restRecipe:RestRecipe?
    
    let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    let selectedtitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedSegmented.setTitleTextAttributes(titleTextAttributes, for: .normal)
        selectedSegmented.setTitleTextAttributes(selectedtitleTextAttributes, for: .selected)
        savedButton.setTitle("Saved", for: UIControl.State.selected)
        if #available(iOS 13.0, *) {
            savedButton.setImage(UIImage(systemName: "bookmark.fill"), for: UIControl.State.selected)
        } else {
            // Fallback on earlier versions  heart_filled
            savedButton.setImage(UIImage(systemName: "bookmark.fill"), for: UIControl.State.selected)
        }
        guard let recipe = shortRecipe else {
            return
        }
        getRecipeDetails(shortRecipe: recipe)
    }
    
    // -------------------------------------------------------------------------
    //MARK:-Helper Methods
    func getRecipeDetails(shortRecipe:ShortRecipe) {
        ApiClient.requestFullRecipe(recipeId: shortRecipe.id) { (response, error) in
            if error == nil {
                if let recipe = response {
                    self.restRecipe = response
                    self.populateRecipe(recipe: recipe)
                    self.checkIfSaved()
                    ApiClient.downloadBannerImage(imageUrl:  recipe.imageUrl) { data, error in
                        guard let data = data else {
                            return
                        }
                        self.imageData = data
                        let image = UIImage(data: data)
                        self.bannerImageView.image = image
                    }
                }
            }
        }
    }
    
    
    func populateRecipe(recipe:RestRecipe)  {
        titleLabel.text = recipe.name
        ingredients = recipe.ingredients
        self.navigationItem.title = recipe.area + " - " + recipe.category
        instructionsTextView.text = recipe.instructions
        tabelView.reloadData()
        showIngredientsorInstructions(selectedSegmentIndex: selectedSegmented.selectedSegmentIndex)
    }
    
    func showIngredientsorInstructions(selectedSegmentIndex:Int) {
        if selectedSegmentIndex == 0{
            ingredientsView.isHidden = false
            instructionsTextView.isHidden = true
        }else if selectedSegmentIndex == 1 {
            instructionsTextView.isHidden = false
            ingredientsView.isHidden = true
        }
    }
    
    /// save recipe to the Core data
    func saveRecipe() {
            let recipe = Recipe(context: DataController.shared.viewContext)
            recipe.name = restRecipe?.name
            recipe.creationDate = Date()
            recipe.id = restRecipe?.id
            recipe.tags = restRecipe?.tags
            recipe.instructions = restRecipe?.instructions
            recipe.imageUrl = restRecipe?.imageUrl
            recipe.imageThumbData = imageData
            recipe.area = restRecipe?.area
            recipe.category = restRecipe?.category
            recipe.source = restRecipe?.source
            recipe.youtubeLink = restRecipe?.youtubeLink
            try? DataController.shared.viewContext.save()
            for ingredient in ingredients {
                let ingre = Ingredients(context: DataController.shared.viewContext)
                ingre.name = ingredient.name
                ingre.quantity = ingredient.quantity
                ingre.recipe = recipe
                try? DataController.shared.viewContext.save()
            }
        savedButton.isSelected = true
        
    }
    
    
    func checkIfSaved()   {
        guard let recipeid = restRecipe?.id else { return }
        //to avoid multiple data we chacke if the recipe is already saved
        guard let isRecipeSaved = recipeExists(recipeId: recipeid) else {
            return
        }
        if isRecipeSaved {
            savedButton.isSelected = true
        }
    }
    
// -------------------------------------------------------------------------
    //MARK:-Actions
    @IBAction func webButtonPressed(_ sender: UIButton) {
        let sourceUrl = restRecipe?.source
        if sourceUrl != ""{ openExternalUrl(url: sourceUrl!)
        }else {
            showAlertDialog(title: "Ooops", message: "Recipe web link seems to be invalid")
        }
    }
    @IBAction func youTubeButtonPressed(_ sender: UIButton) {
        let sourceUrl = restRecipe?.youtubeLink
        if sourceUrl != ""{
            openExternalUrl(url: sourceUrl!)
        }else {
            showAlertDialog(title: "Ooops ...", message: "Recipe youtube links is invalid")
        }
    }
    @IBAction func savedButtonPressed(_ sender: UIButton) {
        if !sender.isSelected {
            saveRecipe()
        }else {
            showToast(message:"Recipe is already saved")
        }
        
    }
    @IBAction func selecedSegmentValueChanged(_ sender: UISegmentedControl) {
        showIngredientsorInstructions(selectedSegmentIndex: sender.selectedSegmentIndex)

    }
    
}
// -------------------------------------------------------------------------
// MARK: ingredients Table View Data Source extention
extension RecipeDetailsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ingredients.count
    }
    
    //formart cell table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kIngredientsCell)!
        let strIngredient2 = self.ingredients[(indexPath as NSIndexPath).row]
        // Set the name and image
        cell.textLabel?.text = strIngredient2.name
        cell.detailTextLabel?.text = strIngredient2.quantity
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}





