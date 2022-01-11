//
//  HomeVC.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 08/05/1443 AH.
//

import UIKit

class HomeVC: UIViewController {

    
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet weak var trendingRecipesCollectionView: UICollectionView!
    //...
    var categories:[FoodCategory] = [
        .init(id: "id1", name: "Asian food0", image: "https://picsum.photos/100/200"),
        .init(id: "id1", name: "Asian food1", image: "https://picsum.photos/100/200"),
        .init(id: "id1", name: "Asian food2", image: "https://picsum.photos/100/200"),
        .init(id: "id1", name: "Asian food3", image: "https://picsum.photos/100/200"),
        .init(id: "id1", name: "Asian food4", image: "https://picsum.photos/100/200")

    ]
    
  var trending: [Recipe] = [
    .init(id: "id1", recipeImage: UIImage(named: "recipeTwo"), categoryOfRecipe: "category", nameOfTheRecipe: "pizza", timerIcon: UIImage(named: "timer"), timeofRecipe: "30 M", hardIcon: UIImage(named: "menu"), hardOfRecipe: "hard", numberOfThePeopleIcon: UIImage(named: "forkAndKnofa"), numberOfPeople: "6 People"),
    
    .init(id: "id1", recipeImage: UIImage(named: "recipeTwo"), categoryOfRecipe: "category", nameOfTheRecipe: "pizza", timerIcon: UIImage(named: "timer"), timeofRecipe: "30 M", hardIcon: UIImage(named: "menu"), hardOfRecipe: "hard", numberOfThePeopleIcon: UIImage(named: "forkAndKnofa"), numberOfPeople: "3 People"),
    
    .init(id: "id1", recipeImage: UIImage(named: "recipeTwo"), categoryOfRecipe: "category", nameOfTheRecipe: "pizza", timerIcon: UIImage(named: "timer"), timeofRecipe: "30 M", hardIcon: UIImage(named: "menu"), hardOfRecipe: "hard", numberOfThePeopleIcon: UIImage(named: "forkAndKnofa"), numberOfPeople: "0 People"),
    
    .init(id: "id1", recipeImage: UIImage(named: "recipeTwo"), categoryOfRecipe: "category", nameOfTheRecipe: "pizza", timerIcon: UIImage(named: "timer"), timeofRecipe: "30 M", hardIcon: UIImage(named: "menu"), hardOfRecipe: "hard", numberOfThePeopleIcon: UIImage(named: "forkAndKnofa"), numberOfPeople: "7 People"),
    
    .init(id: "id1", recipeImage: UIImage(named: "recipeTwo"), categoryOfRecipe: "category", nameOfTheRecipe: "pizza", timerIcon: UIImage(named: "timer"), timeofRecipe: "30 M", hardIcon: UIImage(named: "menu"), hardOfRecipe: "hard", numberOfThePeopleIcon: UIImage(named: "forkAndKnofa"), numberOfPeople: "9 People"),
    
    .init(id: "id1", recipeImage: UIImage(named: "recipeTwo"), categoryOfRecipe: "category", nameOfTheRecipe: "pizza", timerIcon: UIImage(named: "timer"), timeofRecipe: "30 M", hardIcon: UIImage(named: "menu"), hardOfRecipe: "hard", numberOfThePeopleIcon: UIImage(named: "forkAndKnofa"), numberOfPeople: "7 People")
    
    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        //..
        //Menu Button Tint Color...
        //navigationController?.navigationBar.tintColor = .white
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)

    }
    
    
    private func registerCells() {
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        
        trendingRecipesCollectionView.register(UINib(nibName: TrendingResipesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TrendingResipesCollectionViewCell.identifier)
    }
    
}


extension HomeVC: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoryCollectionView:
            return categories.count
        case trendingRecipesCollectionView:
            return trending.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case categoryCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
            cell.setup(category: categories[indexPath.row])
            return cell
        case trendingRecipesCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingResipesCollectionViewCell.identifier, for: indexPath) as! TrendingResipesCollectionViewCell
            cell.setup(recipe:trending[indexPath.row])
            return cell
        default: return UICollectionViewCell()
        }

        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.bounds.width-40, height: view.bounds.width-70)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == categoryCollectionView {
            let controller = ListOfRecipesVC.instantiate()
            controller.category = categories[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        } else {
            if collectionView == trendingRecipesCollectionView {
            let controller =  RecipeDetailsVC.instantiate()
            controller.recipe = trending[indexPath.row]
            navigationController?.present(controller,animated: true, completion: nil)
        }
    }
}
    
}
