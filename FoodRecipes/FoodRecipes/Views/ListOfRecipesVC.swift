//
//  ListOfRecipesVC.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 26/05/1443 AH.
//

import UIKit

class ListOfRecipesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var recipes:[Recipe] = [
        .init(id: "id1", recipeImage: UIImage(named: "recipeTwo"), categoryOfRecipe: "category", nameOfTheRecipe: "pizza", timerIcon: UIImage(named: "timer"), timeofRecipe: "30 M", hardIcon: UIImage(named: "menu"), hardOfRecipe: "hard", numberOfThePeopleIcon: UIImage(named: "forkAndKnofa"), numberOfPeople: "6 People"),
        
        .init(id: "id1", recipeImage: UIImage(named: "recipeTwo"), categoryOfRecipe: "category", nameOfTheRecipe: "pizza", timerIcon: UIImage(named: "timer"), timeofRecipe: "30 M", hardIcon: UIImage(named: "menu"), hardOfRecipe: "hard", numberOfThePeopleIcon: UIImage(named: "forkAndKnofa"), numberOfPeople: "3 People"),
        
        .init(id: "id1", recipeImage: UIImage(named: "recipeTwo"), categoryOfRecipe: "category", nameOfTheRecipe: "pizza", timerIcon: UIImage(named: "timer"), timeofRecipe: "30 M", hardIcon: UIImage(named: "menu"), hardOfRecipe: "hard", numberOfThePeopleIcon: UIImage(named: "forkAndKnofa"), numberOfPeople: "0 People"),
        
        .init(id: "id1", recipeImage: UIImage(named: "recipeTwo"), categoryOfRecipe: "category", nameOfTheRecipe: "pizza", timerIcon: UIImage(named: "timer"), timeofRecipe: "30 M", hardIcon: UIImage(named: "menu"), hardOfRecipe: "hard", numberOfThePeopleIcon: UIImage(named: "forkAndKnofa"), numberOfPeople: "7 People"),
        
        .init(id: "id1", recipeImage: UIImage(named: "recipeTwo"), categoryOfRecipe: "category", nameOfTheRecipe: "pizza", timerIcon: UIImage(named: "timer"), timeofRecipe: "30 M", hardIcon: UIImage(named: "menu"), hardOfRecipe: "hard", numberOfThePeopleIcon: UIImage(named: "forkAndKnofa"), numberOfPeople: "9 People"),
        
        .init(id: "id1", recipeImage: UIImage(named: "recipeTwo"), categoryOfRecipe: "category", nameOfTheRecipe: "pizza", timerIcon: UIImage(named: "timer"), timeofRecipe: "30 M", hardIcon: UIImage(named: "menu"), hardOfRecipe: "hard", numberOfThePeopleIcon: UIImage(named: "forkAndKnofa"), numberOfPeople: "7 People")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: RecipesListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: RecipesListTableViewCell.identifier)
    }

}

extension ListOfRecipesVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipesListTableViewCell.identifier) as! RecipesListTableViewCell
        cell.setup(recipe: recipes[indexPath.row])
        return cell
    }
    
    
}
