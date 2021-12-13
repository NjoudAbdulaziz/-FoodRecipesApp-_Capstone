//
//  CategoryCollectionViewCell.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 08/05/1443 AH.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    static let identifier = String(describing: CategoryCollectionViewCell.self)
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categpryTitleLbl: UILabel!
    
    func setup(category: DishCategory){
        categpryTitleLbl.text = category.name
        categoryImageView.image = category.image
    }
}

//extension String{
//    var asUrl: URL? {
//        return URL(string: self)
//    }
//}
