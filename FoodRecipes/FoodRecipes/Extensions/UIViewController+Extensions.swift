//
//  UIViewController+Extensions.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 29/05/1443 AH.
//

import UIKit

extension UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
    
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
}
