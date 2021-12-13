//
//  TrendingResipesCollectionViewCell.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 08/05/1443 AH.
//

import UIKit

class TrendingResipesCollectionViewCell: UICollectionViewCell {

    static let identifier = String(describing: TrendingResipesCollectionViewCell.self)

    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dishImageView: UIImageView!
    
    
    func setup(dish: Dish){
        titleLbl.text = dish.name
        dishImageView.image = dish.image
    }
}
