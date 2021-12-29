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
    
    var categories:[FoodCategory] = [
//        .init(id: "id1", name: "salad dish1", image: UIImage(named: "LaunchScreen")!),
//        .init(id: "id1", name: "salad dish2", image: UIImage(named: "LaunchScreen")!),
//        .init(id: "id1", name: "salad dish3", image: UIImage(named: "LaunchScreen")!),
//        .init(id: "id1", name: "salad dish4", image: UIImage(named: "LaunchScreen")!),
//        .init(id: "id1", name: "salad dish5", image: UIImage(named: "LaunchScreen")!),

    ]
    
  var trending: [Dish] = [
//        .init(id: "id1", name: "Garri", image: UIImage(named: "LaunchScreen")),
//        .init(id: "id1", name: "Indomie", image: UIImage(named: "LaunchScreen")),
//        .init(id: "id1", name: "Pizza", image: UIImage(named: "LaunchScreen")),
//        .init(id: "id1", name: "Pizza", image: UIImage(named: "LaunchScreen")),

    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        
        //Menu Button Tint Color
        //navigationController?.navigationBar.tintColor = .white
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)

    }
    
    
    private func registerCells() {
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        
        trendingRecipesCollectionView.register(UINib(nibName: TrendingResipesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TrendingResipesCollectionViewCell.identifier)
    }
    
}


extension HomeVC: UICollectionViewDelegate , UICollectionViewDataSource {
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
            cell.setup(dish: trending[indexPath.row])
            return cell
        default: return UICollectionViewCell()
        }

        
    }
    
    
}
